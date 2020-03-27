class DiscoverController < ApplicationController
  
  def index
    @podcasts = Podcast.with_logos
  end

end
