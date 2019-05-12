class DiscoverController < ApplicationController
  def index
    @podcasts = Podcast.all
  end
end
