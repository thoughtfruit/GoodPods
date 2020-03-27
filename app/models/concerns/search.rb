class Search
  extend ActiveSupport::Concern
  def self.search_by_title reference_title
    where("title like ?", "%#{reference_title}%")
  end
    
end
