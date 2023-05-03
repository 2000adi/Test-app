class CreateJoinTableUsersBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false
      t.references :book, null: false
      t.timestamps null: false
    end

    add_index :bookings, %i[user_id book_id], unique: true

    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TRIGGER member_book_limit
          BEFORE INSERT ON bookings
          FOR EACH ROW
          WHEN (
            (SELECT COUNT(*) FROM bookings WHERE user_id = NEW.user_id) >= 5 OR
            (SELECT COUNT(*) FROM users WHERE id = NEW.user_id AND role = 'member') <> 1
          )
          BEGIN
            SELECT RAISE(ABORT, 'member book limit exceeded') WHERE 1;
          END;

          CREATE TRIGGER book_quantity_limit
          BEFORE INSERT ON bookings
          FOR EACH ROW
          WHEN (
            (SELECT quantity FROM books WHERE id = NEW.book_id) <=
            (SELECT COUNT(*) FROM bookings WHERE book_id = NEW.book_id)
          )
          BEGIN
            SELECT RAISE(ABORT, 'book quantity limit exceeded') WHERE 1;
          END;
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP TRIGGER member_book_limit;
          DROP TRIGGER book_quantity_limit;
        SQL
      end
    end
  end
end
