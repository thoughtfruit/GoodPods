class Genre < ApplicationRecord
  belongs_to :user
  belongs_to :podcast
  
  has_many :groups
  
  def self.search_by_title reference_title
    Podcast.where("genre like ?", "%#{reference_title}%")
  end
end

# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  podcast_id :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
