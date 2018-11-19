class AddDoneToCarts < ActiveRecord::Migration[5.2]
  def change
  	add_column :carts, :done, :boolean, default: false
  end
end
