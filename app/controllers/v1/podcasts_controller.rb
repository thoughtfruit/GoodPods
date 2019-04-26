module V1
  class PodcastsController < ApiController
    def index
      @podcasts = Podcast.all
    end
  end
end
