# TODO Refactor this entire file
class DiscoveryService
  def self.start
    DiscoverRankedPodcastsFromChartable.new
  end
end

class DiscoverRankedPodcastsFromChartable

  def initialize
    @pages = (1..10).to_a
    @pages.each do |page_number|
      urls(page_number).each do |url|
        puts "STARTING TO FETCH URL #{url}".red
        discover url
      end
    end
    # Podcast.where(genre: nil).all.each &:destroy
    # Podcast.where(genre: "").all.each &:destroy
  end

  def discover url
    @doc = Nokogiri::HTML(open(url))
    @page_length = @doc.css("div.title").group_by(&:text).length

    if @page_length > 1

      @doc.css('div.title').group_by(&:text).each do |podcast| 

        begin
          title_from_chart = podcast[0].strip
          # podcast_ranking = ranking_algo podcast
          podcast = Podcast.find_by(title: title_from_chart)

          if podcast
            puts "Already have this pod".yellow
            # podcast.update! ranking: podcast_ranking
            t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title}").body
            t = JSON.parse(t)
            podcast.update! itunes_url: t['results'][0]['trackViewUrl']
            podcast.update! genre: t['results'][0]['genres'][0]
            podcast.update! logo_url: t['results'][0]['artworkUrl100']
            podcast.update! logo_url_large: t['results'][0]['artworkUrl600']
          else
            puts "Ready to save new podcast".green
            podcast = Podcast.create!(
              title: title_from_chart,
              # ranking: podcast_ranking,
              network: Network.last,
              cluster: Cluster.last
            )

            t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title}").body
            t = JSON.parse(t)
            podcast.update! logo_url: t['results'][0]['artworkUrl100']
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
    else
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
end
