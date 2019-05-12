class BaseAggObject
  @@feeds = File.parse("/feeds.csv").parse.map(&:url)
end
