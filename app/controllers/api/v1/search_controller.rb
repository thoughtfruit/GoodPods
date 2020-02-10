module Api
  module V1
    class SearchController < ApiController

      def search
        @podcasts = Podcast.search_by_title(params[:s])
        render json: @podcasts
      end

    end
  end
end
