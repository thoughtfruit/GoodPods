module Creators
  class PodcastCreationService

    def initialize(podcast:)
      podcast = Podcast.find_by(title: podcast[0].strip)

      if podcast
        result = PodcastSearchClient.iTunesSearch podcast.title
        podcast.update_from_itunes(result)
      else
        Podcast.create_from_itunes(result)
      end
    end

  end
end
