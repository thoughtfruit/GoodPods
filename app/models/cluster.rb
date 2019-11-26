class Cluster < ApplicationRecord
  has_many :podcasts

  def self.cluster_podcasts_by(options)
    if options.genre
      Genre.find_by(title: options.genre).podcasts if genre_exists?
    elsif options.networks
      Network.find_by(title: options.network).podcasts if network_exists?
    elsif options.podcasts
      cluster_podcasts_by_podcast
    end
  end

  def cluster_podcasts_for_user_by_most_listened_to_genre(user_id)
    genres_user_likes = User.listening_history.podcasts.group_by(&:genre)
    most_active_genre = most_listened_to_genre(genres_user_likes)
    recommended_podcasts = RecommendationEngine.new(
      id: user_id,
      options: {
        by_genre: true,
        genre: most_active_genre
      }
    )
    return {
      most_active_genre => recommended_podcasts
    }
  end

  def cluster_podcasts_by_podcast(podcast_id)
    recommended_podcasts = RecommendationEngine.new(
      id: podcast_id,
      options: {
        by_podcast: true
      }
    )
    return recommended_podcasts
  end

  private
    def genre_exists?
      Genre.where(title: genre)
    end

    def network_exists? 
    end
end
