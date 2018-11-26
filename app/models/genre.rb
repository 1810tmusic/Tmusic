class Genre < ApplicationRecord

	has_many :products
	validates :genre_name, uniqueness: { case_sensitive: false}, presence: true
		# accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true
	default_scope { order(genre_name: :asc) }
end
