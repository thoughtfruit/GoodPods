class Collection < ApplicationRecord
  has_many :podcasts

  # Doesn't use Search mixin b/c needs unique query
  def self.search_by_title reference_title
    where("title like ?", "%#{reference_title}%")
      .first
      .try(:podcasts)
      .try(:uniq)
  end
  
  def self.cluster
    Cluster.by_collections
  end

end