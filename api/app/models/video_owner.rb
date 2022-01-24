class VideoOwner < ActiveRecord::Base
  self.table_name = "video_owner"
  self.primary_key = "id"
end