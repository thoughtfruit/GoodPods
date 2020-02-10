class SearchService
  TABLES = [Podcast, Network, Collection, Genre]

  def initialize(search_for:)
    @search_input = search_for
  end

  def find_matches_in_all_tables 
    TABLES.map { |m| m.search_by_title @search_input }.flaten!
  end

end