class RemoveTriggers < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      DROP TRIGGER IF EXISTS member_book_limit;
      DROP TRIGGER IF EXISTS book_quantity_limit;
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
