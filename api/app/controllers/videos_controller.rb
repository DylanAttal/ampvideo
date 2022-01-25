class VideosController < ApplicationController
  def find_matching_videos
    search_term = params[:search_term]

    @matching_videos = Video.select { |video| video.title.include?(search_term) }.first(10)

    @number_of_times_videos_viewed = VideoViewedLog.group(:video_id).count
    puts "number of times each video was viewed hash"
    puts @number_of_times_videos_viewed
    # ((video_viewed_log.estimated_seconds_watched) / (video.video_length_second)) * (number of views)

    videos_dto = @matching_videos.map { |video|

      owner_name = VideoOwner.find{ |video_owner| video_owner.id == video.video_owner_id }.name
      puts "owner name #{owner_name}"

      {
        title: video.title,
        thumbnail: video.thumbnailurl,
        owner: owner_name
      }
    }

    render json: videos_dto
  end
end
