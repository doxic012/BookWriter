class AddClosedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :closed, :boolean
  end
end
