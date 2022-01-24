class VideosController < ApplicationController
  def find_matching_videos
    search_term = params[:search_term]

    @matching_videos = Video.select { |video| video.title.include?(search_term) }.first(10)

    @number_of_times_videos_viewed = VideoViewedLog.group(:video_id).count
    puts "number of times each video was viewed hash"
    puts @number_of_times_videos_viewed
    # ((video_viewed_log.estimated_seconds_watched) / (video.video_length_second)) * (number of views)

    results = @matching_videos.map { |video|
      {
        title: video.title,
        thumbnail: video.thumbnailurl
      }
    }

    render json: results
  end
end
