class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :cart_id, null: false
      t.integer :shipping_status, default: 0
      t.string :name, null: false
      t.string :name_kana, null: false
      t.string :postal_code, null: false
      t.text :address, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
