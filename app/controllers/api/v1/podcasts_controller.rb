module Api
  module V1
    class PodcastsController < ApplicationController
      respond_to :html, :json

      def index
        @podcasts = Podcast.all.where.not(logo_url: nil).take 100
        render json: @podcasts
      end

      def create
        @podcast = Podcast.create! params
      end

      def show
        @podcast = Podcast.find params[:id]
        @updates = Update.where podcast_id: @podcast.id
        respond_with @podcast
      end

    end
  end
end
