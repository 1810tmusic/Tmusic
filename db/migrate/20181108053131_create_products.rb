class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.text :product_name
      t.string :product_image_id
      t.integer :stock
      t.integer :artist_id
      t.integer :label_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
