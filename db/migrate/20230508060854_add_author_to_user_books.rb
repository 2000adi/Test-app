class AddAuthorToUserBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :user_books, :author, :string
  end
end
