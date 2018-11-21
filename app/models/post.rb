class Post < ApplicationRecord
	include RankedModel
	ranks :row_order
	validates :comment, length: {maximum: 30 }
	belongs_to :product
	belongs_to :user

end
