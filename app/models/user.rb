class User < ActiveRecord::Base

  include SlackApi

  before_save :user_validation

  authenticates_with_sorcery!

  validates :username, presence: true, length: { maximum: 50 }, format: { with: /[a-z]*\.[a-z]*/ }
  validates :name,     presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :lastname, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :email,    presence: true, uniqueness: true

  validates :password, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  scope :admin,   -> (admin) { where admin: admin }
  scope :deleted, -> (deleted) { where deleted: deleted }

  def self.slack_users
    members = SlackApi.get_members

    users = members.map do |member|
      user = {}
      user['username'] =   member['name']
      user['first_name'] = member['profile']['first_name']
      user['last_name']  = member['profile']['last_name']
      user['image_48'] =   member['profile']['image_48']
      user['email'] =      member['profile']['email']
      user['deleted'] =    member['deleted']
      user
    end

    users
  end

  private

  def user_validation
    self.username =   ( /[a-z]*\.[a-z]*/ =~ self.username ) ? self.username : 'no.username'
    self.first_name.presence || 'Noname'
    self.last_name.presence  || 'Noname'
  end

end

