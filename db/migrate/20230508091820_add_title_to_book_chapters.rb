class AddTitleToBookChapters < ActiveRecord::Migration[6.1]
  def change; end
  add_column :book_chapters, :title, :string
end
