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
      self.episode_creator(item)
    end
  end

  def self.episode_creator item
    episode = @podcast.episodes.find_or_create_by(
      title: item.at('title').try(:content),
    )
    episode.update!(
      description: item.at('description').try(:content),
      published: true,
      published_at: item.at('pubDate').try(:content),
      streaming_url: item.at('enclosure').attr('url'),
      guid: item.at('guid').try(:content)
    ) if episode
    puts "Saved episode #{item.at('title').try(:content)}".green
  end

end
