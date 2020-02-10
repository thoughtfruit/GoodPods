class Collection < ApplicationRecord
  has_many :podcasts

  def self.search_by_title reference_title
    # TODO refactor to helper
    where("title like ?", "%#{reference_title}%").first.try(:podcasts)
  end
end
