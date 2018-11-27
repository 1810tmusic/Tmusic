class Song < ApplicationRecord
	belongs_to :disc

	validates :song_no, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end