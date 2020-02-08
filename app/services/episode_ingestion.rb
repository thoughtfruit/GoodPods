class EpisodeIngestion < Service

  def initialize(podcast:)
    @podcast = podcast
    start! if @podcast && @podcast.feed_url
  end

  def start!
    @xml    = Nokogiri::XML(open(@podcast.feed_url))
    channel = @xml.at("rss").at("channel")
    items   = channel.xpath("//item")

    @podcast.episodes.each { |e| e.destroy }
    items.each do |item|
      begin
        p = @podcast.episodes.find_or_create_by!(
          title: item.at('title').content,
        )
        p.update!(
          description: item.at('description').content,
          published: true,
          published_at: item.at('pubDate').content,
          streaming_url: item.at('enclosure').attr('url'),
          guid: item.at('guid').content
        )
      rescue
      end
    end
  end

end
