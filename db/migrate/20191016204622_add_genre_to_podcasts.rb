class AddGenreToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :genre, :text
  end
end
