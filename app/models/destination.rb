class Destination < ApplicationRecord
	belongs_to :user
	has_many :carts, foreign_key: "destination_id"

  def name_and_address
    self.name + "様 (" + self.address + ")"
  end

end
