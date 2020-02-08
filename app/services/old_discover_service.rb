class OldDiscoverService
  def self.sort_by_popularity(podcasts=nil)
    PodcastRankingService.new podcasts
  end
end

class PodcastRankingService

  def initialize podcasts
    @podcasts = podcasts
    @page = 1
    @doc = Nokogiri::HTML(open("https://chartable.com/charts/itunes/us-all-podcasts-podcasts?page=#{@page}"))
    parse
  end

  def parse
    @doc = Nokogiri::HTML(open("https://chartable.com/charts/itunes/us-all-podcasts-podcasts?page=#{@page}"))
    @page_length = @doc.css("div.title").group_by(&:text).length

    if @page_length > 1
      @doc.css('div.title').group_by(&:text).each do |podcast| 
        title_from_chart = podcast[0].strip
        podcast_ranking = ranking_algo podcast
        podcast = Podcast.find_by(title: title_from_chart)
        if podcast
          podcast.update! ranking: podcast_ranking
        else
          # TODO: Put error handling here
          v = Podcast.create! title: title_from_chart, ranking: podcast_ranking, network: Network.last, cluster: Cluster.last
          t = HTTParty.get("https://itunes.apple.com/search?term=#{v.title}").body
          t = JSON.parse(t)
          v.update! logo_url: t['results'][0]['artworkUrl60']
        end
      end
      @page_length -= 1
    end
    @page += 1
    parse
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
