class AggregatorObject
  @@feeds = File.parse("/feeds.csv").parse.map(&:url)
end
