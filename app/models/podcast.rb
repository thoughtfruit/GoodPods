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

  scope :catalog, -> {
    where(xml_valid: true).order("updated_at asc").all
  }

  after_create {
    AsyncEventService.new(
      actor: self,
      steps: [:get_bio, :validate_xml, :get_episodes]
    ).run
  }

  def get_episodes
    ImportEpisodes.for(
      podcast: self
    ).save! if feed_url
  end

  def self.search_by_title reference_title
    where("title like ?", "%#{reference_title}%")
  end

  def new_episodes?
    not match_found?
  end

  def match_found?
    latest_episode_in_local_db == latest_episode_on_remote_url
  end

  def latest_episode_in_local_db
    episodes.first.try(:title)
  end

  def latest_episode_on_remote_url
    ImportEpisodes.for(
      podcast: self
    ).title_of_latest_ep
  end

  def similar_podcasts
    Podcast.where(genre: genre).all.pluck(:title)
  end

  def self.create_from_itunes result
    podcast = Podcast.create!(
      title: result['collectionName'],
      ranking: result['artistId'],
      network: Network.last,
      cluster: Cluster.last,
      logo_url: result['artworkUrl60'],
      feed_url: result['feedUrl'],
      genre: result['genres'] ? result['genres'][0] : '',
      itunes_url: result['trackViewUrl'],
      logo_url_large: result['artworkUrl600']
    )
    podcast
  end

  def update_from_itunes result
    podcast = self.update!(
      title: result['collectionName'],
      ranking: result['artistId'],
      network: Network.last,
      cluster: Cluster.last,
      logo_url: result['artworkUrl60'],
      feed_url: result['feedUrl'],
      genre: result['genres'] ? result['genres'][0] : '',
      itunes_url: t['results'][0]['trackViewUrl'],
      logo_url_large: result['artworkUrl600']
    )
    podcast
  end

  def validate_xml
    if feed_url and XmlValidationService.for(feed_url).valid?
      update! xml_valid: true
    else
      update! xml_valid: false
    end
  end

  def get_bio
    if feed_url
      @feed_xml = Nokogiri::XML(open(feed_url))
      bio = @feed_xml.at('rss').at('channel').at('description').inner_html()
      bio = bio.strip
      update! bio: bio
    end
  end

  def update_logo!
    t = HTTParty.get("https://itunes.apple.com/search?term=#{title} podcast").body
    t = JSON.parse(t)
    update! logo_url: t['results'][0]['artworkUrl100']
    update! logo_url_large: t['results'][0]['artworkUrl600']
  end

  def update_genre!
    begin
      t = HTTParty.get("https://itunes.apple.com/search?term=#{title} podcast").body
      t = JSON.parse(t)
      update! genre: t['results'][0]['genres'][0]
    rescue
      # keep going
    end
  end
end
