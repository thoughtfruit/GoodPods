class SearchService
  MODELS_SUPPORTING_SEARCH_MIXIN = [Podcast, Network, Collection, Genre]

  def initialize(search_for:)
    @search_input = search_for
  end

  def all_tables!
    MODELS.map { |m| m.search_by_title @search_input }.compact.flatten
  end

end
