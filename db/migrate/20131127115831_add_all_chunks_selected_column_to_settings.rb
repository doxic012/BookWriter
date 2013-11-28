class AddAllChunksSelectedColumnToSettings < ActiveRecord::Migration
  def change
    add_column :pdf_export_settings, :allChunks, :boolean, :default => false
  end
end
