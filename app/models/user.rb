class User < ActiveRecord::Base

  before_save :user_correction

  authenticates_with_sorcery!

  validates :username, presence: true, length: { maximum: 50 }, format: { with: /[a-z]*\.[a-z]*/ }
  validates :name,     presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :lastname, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :email,    presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  scope :admin,   -> (admin)   { where admin: admin }
  scope :deleted, -> (deleted) { where deleted: deleted }

  def self.slack_users
    SlackApi.get_users
  end

  private

  def user_correction
    self.username =   ( /[a-z]*\.[a-z]*/ =~ self.username ) ? self.username : 'no.username'
    self.first_name.presence || 'Noname'
    self.last_name.presence  || 'Noname'
  end

end

