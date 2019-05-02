module V1
  class PodcastsController < ApiController
    def index
      @podcasts = Podcast.all
      render json: @podcasts
    end
    def create
      @podcast = Podcast.create! params
    end
  end
end
