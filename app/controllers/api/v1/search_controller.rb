module Api
  module V1
    class SearchController < ApiController
      def search
        # TODO refactor w/following signature + update method name
        # @podcasts = SearchService.find_anything_that_matches(params[:s])
        # 
        # Test version:
        # This must be terrible for performance, aside from it's obviously 
        # beautiful asthetics.
        models_to_search = [Podcast, Network, Collection]
        @podcasts = models_to_search
                      .map { |model| model.search_by_title params[:s] }
                      .inject(:+)
        # Old version:
        # @podcasts = Podcast.search_by_title(params[:s]) + Network.search_by_title(params[:s]) + Collection.search_by_title(params[])
        render json: @podcasts
      end
    end
  end
end
