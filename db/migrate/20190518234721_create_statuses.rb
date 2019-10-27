class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.string :status_name
      t.belongs_to :podcast, foreign_key: true
      t.belongs_to :user, foreign_key: true
    end
  end
end
