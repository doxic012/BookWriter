class ChangeBookUserPdfsettingsRelations < ActiveRecord::Migration
  def up
    remove_column :pdf_export_settings, :user_id

    #create new join table for has_many-through use:
    create_table :authorships do |t|
      t.integer :book_id
      t.integer :user_id

      t.integer :pdf_export_setting_id
    end


    drop_table :books_users
  end

  def down
    add_column :pdf_export_settings, :user_id, :integer

    drop_table :authorships

    #recreate old join table for has_and_belongs_to_many use:
    create_table :books_users, :id => false do |t|
      t.integer :book_id
      t.integer :user_id
    end
  end
end
