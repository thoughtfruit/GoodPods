class AddXmlValidToPodcasts < ActiveRecord::Migration[6.0]
  def change
    add_column :podcasts, :xml_valid, :boolean
  end
end
