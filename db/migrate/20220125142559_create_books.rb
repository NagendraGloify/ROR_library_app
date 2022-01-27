class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :book_name
      t.string :author_name
      t.integer :library_id
      t.integer :user_id

      t.timestamps
    end
    add_index :books, :library_id
    add_index :books, :user_id
  end
end
