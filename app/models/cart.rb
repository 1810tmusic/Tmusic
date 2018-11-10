class Cart < ApplicationRecord
	has_many :cart_items
	has_many :cart_item_products, through: :cart_items, source: :product
	belongs_to :user
end
