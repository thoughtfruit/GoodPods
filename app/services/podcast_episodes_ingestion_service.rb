class PodcastEpisodesIngestionService

  def initialize(podcast:)
    @podcast = podcast
    start!
  end

  def start!
    @xml    = Nokogiri::XML(open(@podcast.feed_url))
    channel = @xml.at("rss").at("channel")
    items   = channel.xpath("//item") 
    items.each do |item|
      @podcast.episodes.create!(
        title: item.at('title').content,
        description: item.at('description').content,
        published: true,
        published_at: item.at('pubDate').content,
        streaming_url: item.at('enclosure').attr('url'),
        guid: item.at('guid').content
      )
    end
  end

end
