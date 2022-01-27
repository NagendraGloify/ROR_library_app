class AddLibraryNameToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :library_name, :string
  end
end
