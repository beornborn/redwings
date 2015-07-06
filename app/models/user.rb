class User < ActiveRecord::Base

  before_save :user_validation

  authenticates_with_sorcery!

  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  scope :admin, -> (admin) { where admin: admin }
  scope :deleted, -> (deleted) { where deleted: deleted }


  def User.slack_users
    data = Slack.get('https://ruby-redwings.slack.com/api/users.list')
    members = data['members']
    users = []
    members.map do |member|
      user = {}
      user['username'] =   member['name']
      user['first_name'] = member['profile']['first_name']
      user['last_name']  = member['profile']['last_name']
      user['image_48'] =   member['profile']['image_48']
      user['email'] =      member['profile']['email']
      user['deleted'] =    member['deleted']
      users.push(user)
    end
    users
  end

  private

  def user_validation
    self.username =   ( /[a-z]*\.[a-z]*/ =~ self.username ) ? self.username : 'no.username'
    self.first_name = ( self.first_name.nil? ) ? 'Noname' : self.first_name
    self.last_name =  ( self.last_name.nil?  ) ? 'Noname' : self.last_name
  end

end

