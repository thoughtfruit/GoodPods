class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
      t.belongs_to :network, foreign_key: true
      t.belongs_to :cluster, foreign_key: true
      t.string :title
      t.string :itunes_url
      t.string :feed_url
      t.integer :user_id

      t.timestamps
    end
  end
end
