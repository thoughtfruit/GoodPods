class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.string :episode
      t.belongs_to :podcast, foreign_key: true
      t.string :title
      t.text :description
      t.boolean :published
      t.string :episode_number
      t.text :streaming_url
      t.date :published_at
      t.text :tags
      t.integer :tier_required
      t.text :guid
    end
  end
end
