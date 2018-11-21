class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :destinations, foreign_key: "user_id"
  has_many :posts, foreign_key: "user_id"
  has_many :products, through: :posts, source: :product
  has_many :carts, foreign_key: "user_id"
  has_many :histories, foreign_key: "user_id"

  # バリデーション
  validates :name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: '名前(カナ)はカタカナで入力してください。' }
  validates :postal_code, presence: true, format: { with: /^[ -~｡-ﾟ]*$/&&/\A\d{7}\z/, message: '郵便番号が正しくありません。ハイフンは入れないでください。'}
  validates :phone_number, presence: true, format: { with: /^[ -~｡-ﾟ]*$/&&/\A\d{10}$|^\d{11}\z/, message: '電話番号が正しくありません。ハイフンは入れないでください。' }

  # 論理削除ユーザーのログイン禁止
  def active_for_authentication?
    super && self.leave_at == nil
  end


end
