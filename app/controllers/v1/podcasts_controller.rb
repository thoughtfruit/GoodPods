module V1
  class PodcastsController < ApiController
    def index
      @podcasts = Podcast.all
    end

    def create
      @podcast = Podcast.create! params
    end
  end
end
