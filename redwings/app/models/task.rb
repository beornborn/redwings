class Task < ActiveRecord::Base
  attr_accessor :name, :story_id, :user_id, :ancestry

  validates :name,  presence: true, length: { maximum: 50 }
  validates :ancestry,  presence: true, length: { maximum: 50 }

  belongs_to :user
  belongs_to :story
end
