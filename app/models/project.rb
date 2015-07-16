class Project < ActiveRecord::Base

  has_many :microposts

  validates :name, presence: true
end
