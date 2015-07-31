class User < ActiveRecord::Base

  has_many :projects_users
  has_many :projects, through: :projects_users

  before_validation :user_correction

  authenticates_with_sorcery!

  attr_accessor :do_password_validation

  validates :username,   presence: true, length: { maximum: 50 }, format: { with: /[a-z]*\.[a-z]*/ }
  validates :first_name, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :last_name,  presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :email,      presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 6 }, if: :do_password_validation
  validates :password_confirmation, presence: true, if: :do_password_validation

  scope :admin,   -> (admin)   { where admin:   admin }
  scope :deleted, -> (deleted) { where deleted: deleted }

  def self.slack_update_users
    slack_users = SlackApi.get_users

    slack_users.map do |slack_user|
      user = User.find_or_initialize_by(email: slack_user['email'])

      academy_project = Project.find_by(name: 'Academy')

      if user.new_record?
        user = User.create! slack_user.merge(password: 'redwings', password_confirmation: 'redwings', started_at: Time.now)
        user.projects << academy_project
      else
        user.attributes = slack_user
        user.save!
      end
    end
  end

  def self.trello_update_users
    Service::Trello.sync
  end

  private

  def user_correction
    self.username =   (/[a-z]*\.[a-z]*/ =~ self.username) ? self.username : "#{self.username}.#{self.username}"
    self.first_name = 'Noname' if self.first_name.blank?
    self.last_name =  'Noname' if self.last_name.blank?
  end

end

