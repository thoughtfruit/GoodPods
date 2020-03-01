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

  after_create {
    get_bio(self) if self.feed_url
  }

  after_save {
    PodcastEpisodesIngestionService.new(podcast: self)
  }

  def self.search_by_title reference_title
    where("title like ?", "%#{reference_title}%")
  end

  def self.create_from_itunes result
    podcast = Podcast.create!(
      podcast_attrs_from_itunes(result)
    )
    podcast
  end

  def update_from_itunes result
    podcast = self.update!(
      podcast_attrs_from_itunes(result)
    )
    podcast
  end

  def similar_podcasts
    Podcast.where(genre: self.genre).all.pluck(:title)
  end

  private
  def podcast_attrs_from_itunes(result)
    {
      title: result['collectionName'],
      ranking: result['artistId'],
      network: Network.last,
      cluster: Cluster.last,
      logo_url: result['artworkUrl60'],
      feed_url: result['feedUrl'],
      genre: result['genres'] ? result['genres'][0] : '',
      itunes_url: t['results'][0]['trackViewUrl'],
      logo_url_large: result['artworkUrl600']
    }
  end

  def get_bio! podcast
    @feed_xml = Nokogiri::XML(open(podcast.feed_url))
    bio = @feed_xml.at('rss').at('channel').at('description').inner_html()
    bio = bio.strip
    podcast.update! bio: bio
  end

  def update_logo!
    t = HTTParty.get("https://itunes.apple.com/search?term=#{self.title} podcast").body
    t = JSON.parse(t)
    self.update! logo_url: t['results'][0]['artworkUrl100']
    self.update! logo_url_large: t['results'][0]['artworkUrl600']
  end

  def update_genre!
    begin
      t = HTTParty.get("https://itunes.apple.com/search?term=#{self.title} podcast").body
      t = JSON.parse(t)
      self.update! genre: t['results'][0]['genres'][0]
    rescue
      # keep going
    end 
  end

  rails_admin do

  end

end
