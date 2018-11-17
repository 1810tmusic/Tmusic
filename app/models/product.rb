class Product < ApplicationRecord

	attachment :product_image

	belongs_to :artist
	belongs_to :genre
	belongs_to :label

	has_many :posts
	has_many :post_users, through: :posts, source: :user

	has_many :prices, foreign_key: "product_id"
	  accepts_nested_attributes_for :prices, reject_if: :all_blank, allow_destroy: true
	has_many :discs,inverse_of: :product
	  accepts_nested_attributes_for :discs, reject_if: :all_blank, allow_destroy: true

	has_many :cart_items, foreign_key: "product_id"

end
