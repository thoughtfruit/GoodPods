class DiscoverService
  def self.start!
    new
  end

  def initialize
    @podcasts = Podcast.all
    @page = 1
    discover
  end

  def discover
    @doc = Nokogiri::HTML(
    	open(
    	"https://chartable.com/charts/spotify/united-states-of-america-comedy?page=#{@page}"
    	)
    )
    @page_length = @doc.css("div.title").group_by(&:text).length

    if @page_length > 1

      @doc.css('div.title').group_by(&:text).each do |podcast| 

        begin
          title_from_chart = podcast[0].strip
          podcast_ranking = ranking_algo podcast
          podcast = Podcast.find_by(title: title_from_chart)

          puts "starting in earnest"

          if podcast
            # podcast.update! ranking: podcast_ranking
            # t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title}").body
            # t = JSON.parse(t)
            # podcast.update! genre: t['results'][0]['genres'][0]
            # podcast.update! logo_url_large: t['results'][0]['artworkUrl600']
          else

            PodcastIngestion.new({title: title_from_chart, ranking: podcast_ranking})

          end
        end
        @page_length -= 1
      rescue
      end
    end
    @page += 1
    discover
  end

  private
  def ranking_algo podcast
    a = 0
    a = @doc.css("div.title").group_by(&:text).find_index(podcast)
    a += 1
    a = a * @page
    return a
  end
  def urls
    [
      "https://chartable.com/charts/spotify/united-states-of-america-comedy?page=#{@page}",
      "https://chartable.com/charts/spotify/united-states-of-america-educational?page=#{@page}",
      "https://chartable.com/charts/spotify/united-states-of-america-top-podcasts",
      "https://chartable.com/charts/spotify/united-states-of-america-stories?page=#{@page}",
      "https://chartable.com/charts/itunes/us-all-podcasts-podcasts?page=#{@page}",
      "https://chartable.com/charts/stitcher/all-most-shared?page=#{@page}",
      "https://chartable.com/charts/stitcher/all-top-movers?page=#{@page}",
      "https://chartable.com/charts/stitcher/all-top-shows?page=#{@page}",
      "https://chartable.com/charts/itunes/us-all-podcasts-podcasts?page=#{@page}"
    ]
  end
end
