module Search
  extend ActiveSupport::Concern
  included do
    def self.search_by_title reference_title
      where("title like ?", "%#{reference_title}%")
    end
  end
end
