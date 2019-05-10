class RemoveStatusIdFromUserPodcastStatuses < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_podcast_statuses, :status_id
  end
end
