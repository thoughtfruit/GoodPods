class AddLastFetchedAtToPodcasts < ActiveRecord::Migration[6.0]
  def change
    add_column :podcasts, :last_fetched_at, :date
  end
end
