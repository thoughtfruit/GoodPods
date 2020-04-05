class Cluster < ApplicationRecord
  has_many :podcasts
  
  def by_collection
    Network::DEFAULTS.each do |network|
      c = Collection.find_or_create_by(title: network)
      PodcastIngestion.find(network).each do |result|
        p = Podcast.find_or_create_by(title: result['collectionName'])
        p.first.update! collection_id: c.id
      end
    end
  end
end

# == Schema Information
#
# Table name: clusters
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
