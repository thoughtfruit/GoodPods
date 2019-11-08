class Podcast < ApplicationRecord
  belongs_to :network, optional: true
  belongs_to :cluster, optional: true

  has_many :episodes

  has_many :genres
  has_many :updates
  has_many :user_podcast_statuses
  has_many :groups

  validates :title, uniqueness: true, on: [:update, :create]

  scope :with_logos, -> { 
    where.not(logo_url: nil).all
  }

  def self.search_by_title reference_title
    where("title LIKE ?", "#{reference_title}%").first
  end

end
