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

    puts members.size

    users = []

    members.map do |member|
      user = {}

      username =   member["name"]
      first_name = member["profile"]["first_name"]
      last_name =  member["profile"]["last_name"]

      user["username"] =   ( /[a-z]*\.[a-z]*/ =~ username ) ? username : "no.username"
      user["first_name"] = ( first_name.nil? ) ? "Noname" : first_name
      user["last_name"]  = ( last_name.nil?  ) ? "Noname" : last_name
      user["image_48"] =   member["profile"]["image_48"]
      user["email"] =      member["profile"]["email"]
      user["deleted"] =    member["deleted"]
      users.push(user)
    end
    users
  end

  def User.is_new?(email)
    !User.where(email: email).exists?
  end

end

