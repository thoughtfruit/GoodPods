class PodcastCreationService
  def initialize(podcast:)
    title_from_chart = podcast[0].strip
    # podcast_ranking = ranking_algo podcast
    podcast = Podcast.find_by(title: title_from_chart)

    if podcast
      # podcast.update! ranking: podcast_ranking
      t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title}").body
      t = JSON.parse(t)
      podcast.update! itunes_url: t['results'][0]['trackViewUrl']
      podcast.update! genre: t['results'][0]['genres'][0]
      podcast.update! logo_url: t['results'][0]['artworkUrl100']
      podcast.update! logo_url_large: t['results'][0]['artworkUrl600']
    else
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
end
