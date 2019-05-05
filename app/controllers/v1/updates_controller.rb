module V1
  class UpdatesController < ApiController

    def index
      @updates = current_user.updates.order("created_at desc").all
      render json: @updates
    end

    def create
      podcast = find_podcast_from_update(params[:body])
      if podcast
        podcast.updates.create! body: params[:body], user_id: current_user.id
      else
        @update = Update.create! body: params[:body], user_id: current_user.id
      end
      render json: @update
    end

    private
    def update_params
      params.require(:update).permit(:body, :title)
    end

    # TODO: This is built to ONLY allow @ to be the last
    # sentence in the update. So I need to extend that
    def find_podcast_from_update(update)
      arr = update.split("@")
      if arr
        podcast_found = arr[1]
        if podcast_found
          title = podcast_found
          return Podcast.where(title: title).first
        end
      end
    end
  end
end
