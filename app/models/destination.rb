class Destination < ApplicationRecord
	belongs_to :user
	has_many :carts, foreign_key: "destination_id"

  [:name, :name_kana, :postal_code, :address, :phone_number].each do |v|
    validates v, presence: true
  end

  def name_and_address
    self.name + "様 (" + self.address + ")"
  end

end
