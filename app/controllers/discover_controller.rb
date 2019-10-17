class DiscoverController < ApplicationController
  def index
    @podcasts = Podcast.all.where.not(logo_url: nil)
  end
end
