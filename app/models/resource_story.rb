class ResourceStory < ActiveRecord::Base
  attr_accessor :resource_id, :story_id, :place_num

  belongs_to :story
  belongs_to :resource
end
