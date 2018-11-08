class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.integer :price
      t.integer :product_id

      t.timestamps
    end
  end
end
