class Scraper::Episodes
  
  def initialize
    Podcast.catalog.each(&method(:import_episodes))
  end
  
  def self.import_episodes podcast
    self.save_episodes(podcast) if podcast.new_episodes?
  end

  def self.save_episodes podcast
    begin
      Ingestion::ImportEpisodes.for(
        podcast: podcast
      ).save!
      podcast.update! last_fetched_at: Date.today
    rescue
    end
  end
  
end
