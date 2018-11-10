class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.string :name, null: false
      t.string :name_kana, null: false
      t.string :postal_code, null: false
      t.text :address, null: false
      t.string :phone_number, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
