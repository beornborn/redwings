module Service::TrelloApi
  class User

  	attr_accessor :email, :username, :full_name

  	def initialize(email, username, full_name)
  	  @email     = email
  	  @username  = username
  	  @full_name = full_name
  	end

  end
end

