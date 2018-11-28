class Product < ApplicationRecord

	validates :discs, presence: true
	validates :product_name, presence: true
	validates :stock, presence: true
	validates :artist_id, presence: true
	validates :label_id, presence: true
	validates :genre_id, presence: true

	attachment :product_image

	belongs_to :artist
	belongs_to :genre
	belongs_to :label

	has_many :posts
	has_many :users, through: :posts, source: :user

	has_many :prices, foreign_key: "product_id"
	  accepts_nested_attributes_for :prices, reject_if: :all_blank, allow_destroy: true

	has_many :discs,inverse_of: :product
	  accepts_nested_attributes_for :discs, reject_if: :all_blank, allow_destroy: true

	has_many :cart_items

	def posted_by?(user)
		posts.where(user_id: user.id).exists?
	end

	def self.search(search)
		if search
			where(['product_name LIKE ?', "%#{search}%"])
		else
			all
		end
	end


end
