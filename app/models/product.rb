class Product < ApplicationRecord

	belongs_to :artist
	belongs_to :genre
	belongs_to :label

	has_many :posts
	has_many :post_users, through: :posts, source: :user

	has_many :prices

	has_many :discs

	has_many :cart_items
end
