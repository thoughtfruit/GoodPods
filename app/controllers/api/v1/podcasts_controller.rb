module Api
  module V1
    class PodcastsController < ApplicationController
      respond_to :html, :json

      def index
        @podcasts = Podcast.with_logos
        render json: @podcasts
      end

      def create
        @podcast = Podcast.create!(params)
      end

      def show
        @podcast    = Podcast.find(params[:id])
        $SITE_TITLE = @podcast.try(:title)
        @updates    = Update.where(podcast_id: @podcast.id)
        respond_with @podcast
      end

    end
  end
end
