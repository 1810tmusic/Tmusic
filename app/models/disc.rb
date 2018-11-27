class Disc < ApplicationRecord

	belongs_to :product
	has_many :songs, inverse_of: :disc
		accepts_nested_attributes_for :songs, reject_if: :all_blank, allow_destroy: true
	
	validates :disc_no, numericality: { only_integer: true, greater_than_or_equal_to: 1 } 


end
