class CreatePdfExportSettings < ActiveRecord::Migration
  def change
    create_table :pdf_export_settings do |t|
      t.boolean :tableOfContent
      t.float :marginTop
      t.float :marginBottom
      t.float :marginRight
      t.float :marginLeft
      t.boolean :insertHead
      t.boolean :insertFoot
      t.text :head
      t.text :foot
      t.references :user

      t.timestamps
    end
    add_index :pdf_export_settings, :user_id
  end
end
