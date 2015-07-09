class User < ActiveRecord::Base

  before_validation :user_correction

  authenticates_with_sorcery!

  validates :username,   presence: true, length: { maximum: 50 }, format: { with: /[a-z]*\.[a-z]*/ }
  validates :first_name, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :last_name,  presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :email,      presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  scope :admin,   -> (admin)   { where admin: admin }
  scope :deleted, -> (deleted) { where deleted: deleted }

  def self.update_users
    slack_users = SlackApi.get_users

    slack_users.map do |slack_user|
      user = User.find_or_create_by(email: slack_user['email']) do |user|
        user.update(slack_user)

        unless user.password
          user.password = 'redwings'
          user.password_confirmation = 'redwings'
        end

      end
    end
  end

  private

  def user_correction
    self.username =   ( /[a-z]*\.[a-z]*/ =~ self.username ) ? self.username : 'no.username'
    self.first_name = 'Noname' if self.last_name.blank?
    self.last_name =  'Noname' if self.last_name.blank?
  end

end

