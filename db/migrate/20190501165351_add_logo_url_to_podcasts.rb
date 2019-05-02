class AddLogoUrlToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :logo_url, :string
  end
end
