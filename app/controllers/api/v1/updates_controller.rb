module Api
  module V1
    class UpdatesController < ApiController
      ON_PODCAST_MENTION_CHARACTER = "@".freeze

      def index
        @updates = Update.all.order "created_at desc"
        render json: @updates
      end

      def create
        podcast = find_podcast_from update: params[:body]
        if podcast
          podcast.updates.create! body: params[:body], user_id: current_user.id
        else
          @update = Update.create! body: params[:body], user_id: current_user.id
        end
        render json: @update
      end

      private
      def update_params
        params.require(:update).permit :body, :title
      end

      # TODO: Allow multiple podcast @ mentions per update
      def find_podcast_from(update:)
        entry = update.split ON_PODCAST_MENTION_CHARACTER
        Podcast.find_by(title: title) if entry and entry[1]
      end
    end
  end
end
