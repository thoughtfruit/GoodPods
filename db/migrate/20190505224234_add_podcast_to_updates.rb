class AddPodcastToUpdates < ActiveRecord::Migration[5.2]
  def change
    add_reference :updates, :podcast, foreign_key: true
  end
end
