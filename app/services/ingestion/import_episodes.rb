class Ingestion::ImportEpisodes

  def self.for(podcast:)
    @podcast = podcast
    xml      = Nokogiri::XML(open(podcast.feed_url))
    channel  = xml.at("rss").at("channel")
    @items   = channel.xpath("//item") if channel
    self
  end

  def self.remote_episodes
    @items
    self
  end

  def self.last
    @items.last
    self
  end

  def self.first
    @items.first
    self
  end

  def self.title_of_latest_ep
    @items.first.at('title').try(:content)
  end

  def self.save!
    @items.each do |item|
      begin
        self.episode_creator(item)
      rescue
        "Failed to save episode #{item.at('title').try(:content)}".red
      end
    end
  end

  def self.episode_creator item
    Creators::EpisodeCreationService
      .for(podcast: @podcast)
      .with(episode: item)
  end

end
