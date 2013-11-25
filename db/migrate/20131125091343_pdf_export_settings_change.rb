class PdfExportSettingsChange < ActiveRecord::Migration
  def change
    change_column_default :pdf_export_settings, :marginTop, 2
    change_column_default :pdf_export_settings, :marginBottom, 2
    change_column_default :pdf_export_settings, :marginLeft, 2
    change_column_default :pdf_export_settings, :marginRight, 2
  end
end
