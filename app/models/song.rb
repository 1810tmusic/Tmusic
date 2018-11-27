class Song < ApplicationRecord

	validates :song_no, presence: true
	validates :song, presence: true

	belongs_to :disc


end

