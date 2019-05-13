class Aggregator # < AggregatorObject

  def initialize
    @@feeds.each { |url| FeedAgg.new(feed_url: url) }
  end

end
