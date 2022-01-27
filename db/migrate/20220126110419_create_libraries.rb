class CreateLibraries < ActiveRecord::Migration[7.0]
  def change
    create_table :libraries do |t|
      t.string :library_name
      t.time :opening_time
      t.time :closing_time
      t.integer :user_id

      t.timestamps
    end
    add_index :libraries, :user_id
  end
end
