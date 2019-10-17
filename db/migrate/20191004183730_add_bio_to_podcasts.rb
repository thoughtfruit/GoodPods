class AddBioToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :bio, :text
  end
end
