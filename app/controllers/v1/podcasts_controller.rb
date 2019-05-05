module V1
  class PodcastsController < ApiController
    def index
      @podcasts = Podcast.all.take(1000)
      render json: @podcasts
    end
    def create
      @podcast = Podcast.create! params
    end
    def show
      @podcast = Podcast.find(params[:id])
      render json: @podcast
    end
  end
end
