class CreateUserPodcastStatus < ActiveRecord::Migration[5.2]
  def change
    create_table :user_podcast_statuses do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :podcast, foreign_key: true
      t.text :status
    end
  end
end
