class VideosController < ApplicationController
  def find_matching_videos
    search_term = params[:search_term]

    @matching_videos = Video.select { |video| video.title.include?(search_term) }.first(10)

    render json: @matching_videos
  end
end
