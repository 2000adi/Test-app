class CreateUserBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string

    create_table :user_books do |t|
      t.string :title
      t.string :summary
      t.string :status, default: 'ongoing'
      t.binary :book_cover
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :book_chapters do |t|
      t.integer :chapter_number
      t.text :content
      t.binary :audio
      t.references :user_book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
