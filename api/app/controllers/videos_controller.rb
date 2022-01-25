class VideosController < ApplicationController
  def find_matching_videos
    search_term = params[:search_term]

    @matching_videos = Video.select { |video| video.title.include?(search_term) }.first(10)

    @number_of_times_videos_viewed = VideoViewedLog.group(:video_id).count

    videos_dto = @matching_videos.map { |video|
      # ((video_viewed_log.estimated_seconds_watched) / (video.video_length_second)) * (number of views)

      seconds_watched = VideoViewedLog.where(video_id: video.id).sum(:estimated_seconds_watched)
      video_length = video.video_length_second
      number_of_views = @number_of_times_videos_viewed[video.id]

      video_rank = (seconds_watched / video_length) * number_of_views

      owner_name = VideoOwner.find{ |video_owner| video_owner.id == video.video_owner_id }.name

      {
        title: video.title,
        thumbnail: video.thumbnailurl,
        owner: owner_name,
        views: number_of_views,
        rank: video_rank
      }
    }

    render json: videos_dto
  end
end
