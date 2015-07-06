class User < ActiveRecord::Base

  include Slack_API

  before_save :user_validation

  authenticates_with_sorcery!

  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  scope :admin, -> (admin) { where admin: admin }
  scope :deleted, -> (deleted) { where deleted: deleted }

  def self.slack_users
    Slack_API.get_slack_users
  end

  private

  def user_validation
    self.username =   ( /[a-z]*\.[a-z]*/ =~ self.username ) ? self.username : 'no.username'
    self.first_name = ( self.first_name.nil? ) ? 'Noname' : self.first_name
    self.last_name =  ( self.last_name.nil?  ) ? 'Noname' : self.last_name
  end

end

