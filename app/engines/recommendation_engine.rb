class RecommendationEngine
  
  def initialize(id:, options:)
    if options.by_genre
      @user = User.find(id)
      return find_most_popular_podcasts_by_genre(options.genre)
    elsif options.by_podcast
      @podcast = Podcast.find(id)
      return find_most_popular_podcasts_related_to_podcast(options.podcast)
    end
  end
  
  private
    def find_most_popular_podcasts_by_genre(genre)
      []
    end
    def find_most_popular_podcasts_related_to_podcast(podcast)
      []
    end
    
end