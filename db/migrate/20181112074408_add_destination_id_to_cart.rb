class AddDestinationIdToCart < ActiveRecord::Migration[5.2]
  def change
  	add_column :carts, :destination_id, :integer
  end
end
