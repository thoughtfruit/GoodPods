class AddLogoUrlLargeToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :logo_url_large, :text
  end
end
