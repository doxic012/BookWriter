class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :edition
      t.date :published
      t.string :genre
      t.string :abstract
      t.string :tags

      t.timestamps
    end
  end
end
