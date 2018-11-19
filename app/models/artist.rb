class Artist < ApplicationRecord

	has_many :products
		# accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true
end
