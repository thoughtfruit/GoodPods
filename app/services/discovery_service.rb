class DiscoveryService

  def self.shows!
    ScrapePodcastsFrom::Chartable.new
  end

  def self.episodes!
    Podcast.catalog.each(&method(:import_episodes))
  end

  def self.import_episodes podcast
    begin
      self.save_episodes(podcast) if podcast.new_episodes?
    rescue
      "Failed to save episode data for #{podcast.to_s}".red
    end
  end

  def self.save_episodes podcast
    Ingestion::ImportEpisodes.for(
      podcast: podcast
    ).save!
    # podcast.update! last_fetched_at: Date.today
  end

end
