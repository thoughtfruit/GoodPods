class ChangeUserPodcastStatuses < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_podcast_statuses, :status
    add_column :user_podcast_statuses, :status, :text
  end
end
