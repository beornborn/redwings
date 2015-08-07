class Project < ActiveRecord::Base
  has_many :projects_users
  has_many :users, through: :projects_users

  validates :name, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }

  scope :project_by_name, -> (name) { where(name: name) }
end

