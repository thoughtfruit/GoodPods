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

# == Schema Information
#
# Table name: collections
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
