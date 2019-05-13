# Functional style b/c I don't want errors or bad data to propegate
# You could argue you want to do all of this async and let
# potentially bad data populate into data store - but I don't want that.
class Feed # < Aggregator

  def initialize(feed_url:)
    @url ||= feed_url
    validate
  end

  def validate
    build if valid? or validation_error
  end

  def build
    save if built? or build_error
  end

  def save
    episodes if saved? or save_error
  end

  def validation_error
    puts "validation error hit"
    # Failed to validate XML
  end

  def build_error
    # Failed to build the feed object
  end

  def save_error
    # Failed to save the feed object
  end

  private
  def valid?
    @validator = XmlValidator.new
    @validator.for(@url).validate # => true/false
  end
  # Cache locally on the object - other methods on obj will call this method
  # Instance variable is to be ignored - just there for additional caching mechanics
  def valid_xml
    @_valid_xml ||= @validator.schema # => Valid XML (can't reach this method without xml - no error state neeeded)
  end
  def built?
    @feed ||= FeedObject.new(
      url: @feed_url,
      valid_xml: valid_xml
    ).build!
    @feed.built?
  end
  # TODO: Diff style method below than above, refactor to match
  def saved?
    @saver = FeedSaver.new
    @saver.save feed_object: @feed # => true/false
  end
end
