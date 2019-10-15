class DiscoverController < ApplicationController
  def index
    @podcasts = Podcast.all.where.not(logo_url: nil)

    @sorted_podcasts = DiscoverService.sort_by_popularity(@podcasts)
    @sorted_podcasts
  end
end
