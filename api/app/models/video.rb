class Video < ActiveRecord::Base
  self.table_name = "videos"
  self.primary_key = "id"
  belongs_to :video_owner
end