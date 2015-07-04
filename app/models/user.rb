class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :name,     presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :lastname, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :email,    presence: true, uniqueness: true

  validates :password, confirmation: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true

  scope :admin, -> (admin) { where admin: admin }
  scope :deleted, -> (deleted) { where deleted: deleted }

  def User.slack_users
  	data_hash = Slack.get("https://ruby-redwings.slack.com/api/users.list")
  	members_hash = data_hash["members"]

  	users = []
  	user = {}

  	profile_hash = {}

    # filtered importent attr
  	members_hash.each do |member|
  	  user["name"] = member["name"]
  	  user["deleted"] = member["deleted"]
      user["first_name"] = member["profile"]["first_name"]
  	  user["last_name"] = member["profile"]["last_name"]
  	  user["image_48"] = member["profile"]["image_48"]
  	  user["email"] = member["profile"]["email"]

  	  users << user
  	  user = {}
  	end
    users
  end

end

