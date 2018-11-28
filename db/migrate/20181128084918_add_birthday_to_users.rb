class AddBirthdayToUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :birthday, :date, null: false
  end

  def down
    add_column :users, :birthday, :date, null: false
  end
end
