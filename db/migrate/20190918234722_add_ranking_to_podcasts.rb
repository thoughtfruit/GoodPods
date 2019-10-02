class AddRankingToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :ranking, :integer
  end
end
