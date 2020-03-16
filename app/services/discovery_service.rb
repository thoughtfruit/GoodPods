class DiscoveryService

  def initialize ; end

  def self.shows!
    ScrapePodcastsFrom::Chartable.new
  end

  def self.episodes!
    Podcast.catalog.each(&method(:import_episodes))
  end

  def self.import_episodes podcast
    self.save_episodes(podcast) if podcast.new_episodes?
  end

  def self.save_episodes podcast
    Ingestion::ImportEpisodes.for(
      podcast: podcast
    ).save!
    podcast.update! last_fetched_at: Date.today
  end
end
