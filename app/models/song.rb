class Song < ApplicationRecord

	validates :song_no, presence: true
	validates :song, presence: true

	belongs_to :disc

	validates :song_no, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end