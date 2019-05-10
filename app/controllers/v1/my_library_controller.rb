module V1
  class MyLibraryController < ApiController
    def all_library
      render json: UserPodcastStatus.where(
        user: current_user
      ).all
    end
    def status_for_podcast_and_user
      render json: UserPodcastStatus.where(
        podcast_id: params[:podcast_id],
        user_id: current_user.id
      ).map(&:status)

    end

    def create
      puts params

      status_map = UserPodcastStatus.find_or_create_by(
        podcast: Podcast.find(params[:podcast_id]),
        status: Status.find(params[:save_to_list]),
        user: current_user
      )

      render json: status_map
    end

    def delete_status_for_podcast_and_user
      d = UserPodcastStatus.where(
        podcast: Podcast.find(params[:podcast_id]),
        status: Status.find(params[:list]),
        user: current_user
      ).all.each(&:destroy)
      render json: d
    end
  end
end
