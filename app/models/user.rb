class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :username,   presence: true, length: { maximum: 50 }, format: { with: /[a-z]*\.[a-z]*/ }
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

    members.map do |member|
      user = {}
      user["username"] =   member["name"]
      user["deleted"] =    member["deleted"]
      user["first_name"] = member["profile"]["first_name"]
      user["last_name"] =  member["profile"]["last_name"]
      user["image_48"] =   member["profile"]["image_48"]
      user["email"] =      member["profile"]["email"]
      users.push(user)
    end
    users
  end

  def User.is_new?(email)
    !User.where(email: email).exists?
  end

end

