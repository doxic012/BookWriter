class ChunksPdfsettingsAssociation < ActiveRecord::Migration
  def change
    create_table :chunks_pdf_export_settings, :id => false do |t|
      t.integer :chunk_id
      t.integer :pdf_export_setting_id
    end
  end

end
