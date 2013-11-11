class CreateBooksUsers < ActiveRecord::Migration
  def change
    create_table :books_users, :id => false do |t|
      t.integer :book_id
      t.integer :user_id
    end
  end
end