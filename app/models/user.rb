class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :username,   presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :first_name, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :last_name,  presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :email,      presence: true, uniqueness: true

  validates :password, confirmation: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true

  scope :admin, -> (admin) { where admin: admin }
  scope :deleted, -> (deleted) { where deleted: deleted }


  def User.slack_users
    data = Slack.get("https://ruby-redwings.slack.com/api/users.list")
    members = data["members"]

    users = []
    user = {}

    members.each do |member|
      user["username"] =   member["name"]
      user["deleted"] =    member["deleted"]
      user["first_name"] = member["profile"]["first_name"]
      user["last_name"] =  member["profile"]["last_name"]
      user["image_48"] =   member["profile"]["image_48"]
      user["email"] =      member["profile"]["email"]
      users << user
      user = {}
    end
    users
  end

  def User.is_new?(email)
    users = User.all
    users.each do |user|
      return false if user.email == email
    end
    true
  end

end

