class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.text :product_name, null: false
      t.string :product_image_id
      t.integer :stock, null: false
      t.integer :artist_id, null: false
      t.integer :label_id, null: false
      t.integer :genre_id, null: false

      t.timestamps
    end

    add_index :products, :product_name
  end
end
