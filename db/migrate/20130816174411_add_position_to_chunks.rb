class AddPositionToChunks < ActiveRecord::Migration
  def change
    add_column :chunks, :position, :integer
  end
end
