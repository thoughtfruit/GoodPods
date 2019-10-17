class Podcast < ApplicationRecord
<<<<<<< HEAD
  belongs_to :network
  belongs_to :cluster

  has_many :episodes
=======
  belongs_to :network, optional: true
  belongs_to :cluster, optional: true
>>>>>>> 1392ca6b52d4e5360b8677fb1273e9ac8e453bc4
  has_many :genres
  has_many :updates
  has_many :user_podcast_statuses
  has_many :groups

  validates :title, uniqueness: true, on: [:update, :create]

  def list_count
    @_list_count ||= UserPodcastStatus.where(podcast_id: self.id).size
  end

end
