module V1
  class UpdatesController < ApiController

    def index
      @updates = Update.all
      render json: @updates
    end

    def create
      @update = Update.create! body: params[:body], user_id: current_user.id
      render json: @update
    end

    private
    def update_params
      params.require(:update).permit(:body, :title)
    end

  end
end
