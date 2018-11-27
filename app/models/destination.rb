class Destination < ApplicationRecord
	belongs_to :user
	has_many :carts, foreign_key: "destination_id"

  [:name, :name_kana, :postal_code, :address, :phone_number].each do |v|
    validates v, presence: true
  end
  validates :name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力してください。' }
  validates :postal_code, presence: true, format: { with: /^[ -~｡-ﾟ]*$/&&/\A\d{7}\z/, message: 'はハイフンを入れずに入力してください。'}
  validates :phone_number, presence: true, format: { with: /^[ -~｡-ﾟ]*$/&&/\A\d{10}$|^\d{11}\z/, message: 'はハイフンを入れずに入力してください。' }


  def name_and_address
    self.name + "様 (" + self.address + ")"
  end

end
