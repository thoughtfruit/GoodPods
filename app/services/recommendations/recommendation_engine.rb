class Recommendations::RecommendationEngine

  def initialize options

    if options.genre
      find_most_popular_podcasts_by_genre options.genre

    elsif options.podcast and not options.bio
      find_most_popular_podcasts_related_to_podcast options.podcast

    elsif options.bio and options.podcast
      find_most_popular_podcasts_related_to_entities_extracted_from_bio options
    end

  end

  def find_most_popular_podcasts_by_genre genre
    ClusterService.find_most_popular_podcasts_within_genre genre
  end

  def find_most_popular_podcasts_related_to_podcast podcast
    ClusterService.cluster_podcasts_by_podcast podcast
  end

  def find_most_popular_podcasts_related_to_entities_extracted_from_bio options
    ClusterService.cluster_by_bio_similarity_algorithm(
      with: options.bio,
      from: options.podcast
    )
  end
  
end