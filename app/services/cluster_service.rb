class ClusterService

  def find_most_popular_podcasts_within_genre genre
    Podcast.where(genre: genre).order('popularity desc')
  end

  def cluster_podcasts_by_podcast(podcast)
    {
      original_podcast: podcast,
      podcasts_like_original: podcast.similar_podcasts
    }
  end

  def cluster_by_bio_similarity_algorithm options
    {
      original_podcast: options.podcast
      podcasts_with_similar_bio: LanguageProcessor::Bio.new(options.podcast).like_podcast
    }
  end

  private
  def genre_exists?
    Genre.where(title: genre)
  end

  def network_exists?
  end

end
