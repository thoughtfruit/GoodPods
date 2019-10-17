class DiscoverService
  def self.start!
    DiscoverRankedPodcasts.new
  end
end

class DiscoverRankedPodcasts

  def initialize
    @podcasts = Podcast.all
    @page = 1
    urls.each do |url|
      discover url
    end
  end

  def discover url
    @doc = Nokogiri::HTML(open(url))
    @page_length = @doc.css("div.title").group_by(&:text).length

    if @page_length > 1

      @doc.css('div.title').group_by(&:text).each do |podcast| 

        begin
          title_from_chart = podcast[0].strip
          podcast_ranking = ranking_algo podcast
          podcast = Podcast.find_by(title: title_from_chart)

          if podcast
            # podcast.update! ranking: podcast_ranking
            # t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title}").body
            # t = JSON.parse(t)
            # podcast.update! genre: t['results'][0]['genres'][0]
            # podcast.update! logo_url_large: t['results'][0]['artworkUrl600']
          else
            podcast = Podcast.create!(
              title: title_from_chart,
              ranking: podcast_ranking,
              network: Network.last,
              cluster: Cluster.last
            )

            t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title}").body
            t = JSON.parse(t)
            podcast.update! logo_url: t['results'][0]['artworkUrl60']
            podcast.update! feed_url: t['results'][0]['feedUrl']
            podcast.update! genre: t['results'][0]['genres'][0]
            podcast.update! logo_url_large: t['results'][0]['artworkUrl600']

            @feed_xml = Nokogiri::XML(open(t['results'][0]['feedUrl']))
            bio = @feed_xml.at('rss').at('channel').at('description').inner_html()
            bio = bio.strip
            podcast.update! bio: bio

            PodcastEpisodesIngestionService.new(podcast: podcast)
          end
        end
        @page_length -= 1
      rescue
      end
    end
  end

  def recurse url
    discover url
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
