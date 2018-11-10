class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.integer :price, null: false
      t.integer :product_id, null: false

      t.timestamps
    end
  end
end
