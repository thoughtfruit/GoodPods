class Collection < ApplicationRecord
  has_many :podcasts

  def self.search_by_title reference_title
    # TODO refactor to helper
    where("title like ?", "%#{reference_title}%").first.try(:podcasts).try(:uniq)
  end

  def self.remap_collections! 
    Network::DEFAULTS.each do |network|
      c = Collection.find_or_create_by(title: network)
      PodcastIngestion.find(network).each do |result|
        p = Podcast.find_or_create_by(title: result['collectionName'])
        p.first.update! collection_id: c.id
      end
    end
  end

end
