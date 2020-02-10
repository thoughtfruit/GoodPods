class Network < ApplicationRecord
  has_many :podcasts

  def self.search_by_title reference_title
    # TODO refactor to helper E.g. search_by_title
    where("title ilike ?", "%#{reference_title}%")
  end
end
