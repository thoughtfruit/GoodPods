class Podcast < ApplicationRecord
  belongs_to :network, optional: true
  belongs_to :cluster, optional: true

  has_many :episodes

  has_many :genres
  has_many :updates
  has_many :user_podcast_statuses
  has_many :groups

  validates :title, uniqueness: true, on: [:update, :create]

  def list_count
    @_list_count ||= UserPodcastStatus.where(podcast_id: self.id).size
  end

  def self.with_logos
    Podcast.all.where.not(logo_url: nil)
  end

  def self.search_by_title reference_title
    Podcast.where("title LIKE ?", "#{reference_title}%")
  end

  def self.import_from_search name
    v = JSON.parse(HTTParty.get("https://itunes.apple.com/search?term=#{name}").body)
    v.fetch('results').each do |r|
      if Podcast.find_by(title: r['collectionName'])
      else
        puts "Starting for #{r['collectionName']}".green
        podcast = Podcast.find_or_create_by(
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
