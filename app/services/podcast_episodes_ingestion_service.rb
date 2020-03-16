class PodcastEpisodesIngestionService

  def initialize(podcast:)
    @podcast = podcast
    xml      = Nokogiri::XML(open(@podcast.feed_url))
    @channel = xml.at("rss").at("channel")
    @items   = @channel.xpath("//item") if @channel or []
  end

  def remote_episodes
    @items
    self
  end

  def last
    @items.last
    self
  end

  def first
    @items.first
    self
  end

  def title
    @items.first.at('title').try(:content)
  end

  def save!
    @items.each do |item|
      episode_creator(item)
    end
  end

  def episode_creator item
    begin
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
    rescue
      puts "Failed to save episode".red
    end
  end

end
