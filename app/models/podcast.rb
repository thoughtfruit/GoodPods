class Podcast < ApplicationRecord
  belongs_to :network
  belongs_to :cluster
  has_many :genres
  has_many :updates
  has_many :user_podcast_statuses

  validates :title, uniqueness: true, on: [:update, :create]
end
