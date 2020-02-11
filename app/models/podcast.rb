class Podcast < ApplicationRecord
  belongs_to :network, optional: true
  belongs_to :cluster, optional: true
  belongs_to :collection, optional: true

  has_many :episodes

  has_many :genres
  has_many :updates
  has_many :user_podcast_statuses
  has_many :groups

  validates :title, uniqueness: true, on: [:update, :create]

  scope :with_logos, -> {
    where.not(logo_url: nil).order("created_at asc").all
  }

  def self.search_by_title reference_title
    where("title like ?", "%#{reference_title}%")
  end

  def self.create_from_itunes result
    podcast = self.create!(
      title: result['collectionName'],
      ranking: result['artistId'],
      network: Network.last,
      cluster: Cluster.last,
      logo_url: result['artworkUrl60'],
      feed_url: result['feedUrl'],
      genre: result['genres'] ? result['genres'][0] : '',
      logo_url_large: result['artworkUrl600']
    )
    self.create_bio(podcast)
    return podcast
  end

  def self.create_bio podcast
    if podcast.feed_url
      @feed_xml = Nokogiri::XML(open(podcast.feed_url))
      bio = @feed_xml.at('rss').at('channel').at('description').inner_html()
      bio = bio.strip
      podcast.update! bio: bio
    end
  end

end
