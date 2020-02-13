class DiscoveryService
  def self.start
    ScrapePodcastsFromUrlsOnChartable.new
  end
end

class ScrapePodcastsFromUrlsOnChartable

  def initialize
    pages_to_iterate.each do |page_number|
      urls(page_number).each do |url|
        @url = url
        discover url
      end
    end
  end

  def discover url
    if podcasts_on_page?
      podcasts.each do |podcast|
        begin
          PodcastCreationService.new(podcast: podcast)
          @page_length -= 1
        rescue
        end
      end
    end
  end

  def podcasts_on_page?
    page_length > 1
  end

  def doc
    Nokogiri::HTML(open(@url))
  end

  def podcasts
    doc.css('div.title').group_by(&:text)
  end

  def page_length
    @page_length = doc.css("div.title").group_by(&:text).length
  end

  def pages_to_iterate
    (1..10).to_a
  end

  def urls page_number
    [
      "https://chartable.com/charts/spotify/united-states-of-america-comedy?page=#{page_number}",
      "https://chartable.com/charts/spotify/united-states-of-america-educational?page=#{page_number}",
      "https://chartable.com/charts/spotify/united-states-of-america-top-podcasts",
      "https://chartable.com/charts/spotify/united-states-of-america-stories?page=#{page_number}",
      "https://chartable.com/charts/itunes/us-all-podcasts-podcasts?page=#{page_number}",
      "https://chartable.com/charts/stitcher/all-most-shared?page=#{page_number}",
      "https://chartable.com/charts/stitcher/all-top-movers?page=#{page_number}",
      "https://chartable.com/charts/stitcher/all-top-shows?page=#{page_number}",
      "https://chartable.com/charts/itunes/us-all-podcasts-podcasts?page=#{page_number}"
    ]
  end

  private
  def ranking_algo podcast
    a = 0
    a = @doc.css("div.title").group_by(&:text).find_index(podcast)
    a += 1
    a = a * @page
    return a
  end
end

# Podcast.where(genre: nil).all.each &:destroy
# Podcast.where(genre: "").all.each &:destroy
