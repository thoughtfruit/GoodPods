class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :podcast, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
