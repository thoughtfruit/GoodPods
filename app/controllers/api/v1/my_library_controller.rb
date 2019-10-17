module Api
  module V1
    class MyLibraryController < ApplicationController
      respond_to :json

      def all_library
        @my_library = Library.where(
          user: current_user || params[:user_id] || NullUser.new
        ).all
        render json: @my_library
      end

      def status_for_podcast_and_user
        @statuses = UserPodcastStatus.where(
          podcast_id: params[:podcast_id],
          user_id: current_user.try(:id) || params[:user_id] || NulllUser.new
        ).map(&:status)
        render json: @statuses
      end

      def create
        @created = UserPodcastStatus.find_or_create_by(
          podcast: Podcast.find(params[:podcast_id]),
          status: Status.find(params[:save_to_list]),
          user: current_user
        )
        render json: @created
      end

      def delete_status_for_podcast_and_user
        @deleted = UserPodcastStatus.where(
          podcast: Podcast.find(params[:podcast_id]),
          status: Status.find(params[:list]),
          user: current_user
        ).map(&:destroy)
        render json: @deleted
      end
    end
  end
end
