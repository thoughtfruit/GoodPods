module Api
  module V1
    class SearchController < ApiController
      def search
        @podcasts = Podcast.where("title LIKE ?", "#{params[:s]}%")
        render json: @podcasts
      end
    end
  end
end
