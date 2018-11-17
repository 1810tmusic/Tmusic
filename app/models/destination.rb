class Destination < ApplicationRecord
	belongs_to :user
	has_many :carts, foreign_key: "destination_id"
end
