class Resource < ActiveRecord::Base
  attr_accessor :url, :description, :type

  validates :url,  presence: true, length: { maximum: 255 }
  validates :description,  presence: true, length: { maximum: 255 }
  validates :type,  presence: true, length: { maximum: 50 }

  has_many :resource_stories
end
