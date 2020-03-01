module WikipediaClient
  URL = "http://wikipedia.org"

  def self.search_by_topic topic
    JSON.parse(HTTParty.get(URL + "/topic/#{topic}").body)
  end

  class Checker

    def self.is_entity? word
      word and not WikipediaClient.search_by_topic(word).null?
    end
  end

end
