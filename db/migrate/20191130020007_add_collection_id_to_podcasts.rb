class AddCollectionIdToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :collection_id, :integer
  end
end
