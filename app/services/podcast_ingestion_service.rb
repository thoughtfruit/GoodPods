class PodcastIngestion
  def self.import_from_search name
    v = JSON.parse(HTTParty.get("https://itunes.apple.com/search?term=#{name}").body)
    v.fetch('results').each do |r|
      unless Podcast.where(title: r['collectionName']).any?
        puts "Starting for #{r['collectionName']}".green
        podcast = Podcast.create(
          title: r['collectionName'],
          ranking: r['artistId'],
          network: Network.last,
          cluster: Cluster.last,
          logo_url: r['artworkUrl60'],
          feed_url: r['feedUrl'],
          genre: r['genres'] ? r['genres'][0] : '',
          logo_url_large: r['artworkUrl600']
        )

        puts "Created podcast".green

        @feed_xml = Nokogiri::XML(open(r['feedUrl']))
        bio = @feed_xml.at('rss').at('channel').at('description').inner_html()
        bio = bio.strip
        podcast.update! bio: bio
        PodcastEpisodesIngestionService.new(podcast: podcast)
        puts "Finished updating #{podcast.title}".red
      end
    end
  end
end