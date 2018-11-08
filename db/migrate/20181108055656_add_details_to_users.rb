class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :name_kana, :string
    add_column :users, :postal_code, :string
    add_column :users, :address, :text
    add_column :users, :phone_number, :string
    add_column :users, :email, :text
    add_column :users, :password, :string
    add_column :users, :admin, :boolean
    add_column :users, :nickname, :string
    add_column :users, :birthday, :date
    add_column :users, :leave_at, :string
    add_column :users, :datetime, :string
  end
end
