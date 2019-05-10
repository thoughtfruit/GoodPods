module V1
  # TODO: Update this name
  class MyLibraryController < ApiController

    # TODO: Update this name
    def all_library
      render json: UserPodcastStatus.where(
        user: current_user
      ).all
    end

    # TODO: Update this name
    def status_for_podcast_and_user
      render json: UserPodcastStatus.where(
        podcast_id: params[:podcast_id],
        user_id: current_user.id
      ).map(&:status)
    end

    def create
      render json: UserPodcastStatus.find_or_create_by(
        podcast: Podcast.find(params[:podcast_id]),
        status: Status.find(params[:save_to_list]),
        user: current_user
      )
    end

    # TODO: Update this name
    def delete_status_for_podcast_and_user
      render json: UserPodcastStatus.where(
        podcast: Podcast.find(params[:podcast_id]),
        status: Status.find(params[:list]),
        user: current_user
      ).all.map(&:destroy)
    end
  end
end
