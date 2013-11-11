class CreateChunks < ActiveRecord::Migration
  def change
    create_table :chunks do |t|
      t.string :title
      t.string :section
      t.text :content
      t.references :user
      t.references :book

      t.timestamps
    end
  end
end