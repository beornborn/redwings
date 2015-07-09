class User < ActiveRecord::Base

  before_save :user_correction

  authenticates_with_sorcery!

  validates :username, presence: true, length: { maximum: 50 }, format: { with: /[a-z]*\.[a-z]*/ }
  validates :first_name,     presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :last_name, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :email,    presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  scope :admin,   -> (admin)   { where admin: admin }
  scope :deleted, -> (deleted) { where deleted: deleted }

  def self.update_users
    slack_users = SlackApi.get_users

    slack_users.map do |slack_user|
      user = User.where(email: slack_user['email'])

      unless user.exists?
        User.create slack_user.merge(password: 'redwings', password_confirmation: 'redwings')
      else
        user.update_all(slack_user)
      end

    end
  end

  private

  def user_correction
    self.username =   ( /[a-z]*\.[a-z]*/ =~ self.username ) ? self.username : 'no.username'
    self.first_name.presence || 'Noname'
    self.last_name.presence  || 'Noname'
  end

end

