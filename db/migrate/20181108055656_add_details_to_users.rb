class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :name, :string
    add_column :users, :name_kana, :string
    add_column :users, :postal_code, :string
    add_column :users, :address, :text
    add_column :users, :phone_number, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :nickname, :string
    add_column :users, :birthday, :date
    add_column :users, :leave_at, :datetime
    change_column :users, :name, :string, null: false
    change_column :users, :name_kana, :string, null: false
    change_column :users, :postal_code, :string, null: false
    change_column :users, :address, :string, null: false
    change_column :users, :phone_number, :string, null: false
    change_column :users, :nickname, :string, null: false
    change_column :users, :birthday, :date, null: false
  end

  def down
    remove_column :users, :name, :string
    remove_column :users, :name_kana, :string
    remove_column :users, :postal_code, :string
    remove_column :users, :address, :string
    remove_column :users, :phone_number, :string
    remove_column :users, :nickname, :string
    remove_column :users, :birthday, :string
  end
end
