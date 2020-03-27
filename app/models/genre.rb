class Genre < ApplicationRecord
  belongs_to :user
  belongs_to :podcast
  
  has_many :groups
  
  def self.search_by_title reference_title
    Podcast.where("genre like ?", "%#{reference_title}%")
  end
end
