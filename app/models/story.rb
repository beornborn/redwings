class Story < ActiveRecord::Base
  attr_accessor :name

  validates :name,  presence: true, length: { maximum: 50 }
  
  has_many :tasks
  belongs_to :resource_story
end
