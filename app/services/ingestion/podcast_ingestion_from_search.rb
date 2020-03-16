module Ingestion
  class PodcastIngestionFromSearch

    def self.search term
      self.find(term).each { |podcast| self.import(podcast) unless podcast.none? }
    end

    def self.find term
      podcasts = JSON.parse(HTTParty.get("https://itunes.apple.com/search?term=#{term}").body)
      results = podcasts.fetch('results')
      return results.any? ? results : []
    end

    def self.import result
      podcast = self.create_podcast_with(result) unless self.any_podcast_found_from_itunes?(result)
      PodcastEpisodesIngestionService.new(podcast: podcast) if podcast
    end

    private
    def self.create_podcast_with result
      if any_podcast_found_from_itunes?(result)
        podcast = Podcast.update_from_itunes(result)
        puts "Updated podcast #{podcast.title}".yellow
      else
        podcast = Podcast.create_from_itunes(result)
        puts "Created podcast #{podcast.title}".green
      end
      return podcast
    end

    def self.any_podcast_found_from_itunes? result
      Podcast.where(title: result['collectionName']).any?
    end
  end
end