class Project < ActiveRecord::Base

  has_many :users

  validates :name, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }

end

