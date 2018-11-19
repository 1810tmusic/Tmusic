class Cart < ApplicationRecord
	has_many :cart_items, foreign_key: "cart_id"
	has_many :cart_item_products, through: :cart_items, source: :product
	belongs_to :user
	has_one :history, foreign_key: "cart_id"
	belongs_to :destination
end
