# Agg = Aggregator
class Feed < Agg

  def initialize(feed_url:)
    @feed_url = feed_url
  end

  def validate
    save if valid? or error
  end

  def save
    episodes if saved? or error
  end

  def episodes
    strip_episodes
  end

  def error
  end

  private
  def valid?
    PodcastXmlValiator.new(@feed_url) # => true/false
  end
  def saved?
    PodcastFeedSaver.new(@feed_url) # => true/false
  end
end
