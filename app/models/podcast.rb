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

end
