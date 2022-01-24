class VideoViewedLog < ActiveRecord::Base
  self.table_name = "video_viewed_log"
  self.primary_key = "id"
end