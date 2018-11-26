class Label < ApplicationRecord

	has_many :products
	validates :label_name, uniqueness: { case_sensitive: false}, presence: true
	# accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true
	default_scope { order(label_name: :asc) }
end
