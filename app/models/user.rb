class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :destinations, foreign_key: "user_id", dependent: :destroy
  has_many :posts, foreign_key: "user_id"
  has_many :products, through: :posts, source: :product
  has_many :carts, foreign_key: "user_id"
  has_many :histories, foreign_key: "user_id"

  # バリデーション
  validates :name, presence: true
  validates :name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力してください。' }
  validates :nickname, presence: true
  validates :postal_code, presence: true, format: { with: /^[ -~｡-ﾟ]*$/&&/\A\d{7}\z/, message: 'が正しくありません。ハイフンは入れないでください。'}
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /^[ -~｡-ﾟ]*$/&&/\A\d{10}$|^\d{11}\z/, message: 'が正しくありません。ハイフンは入れないでください。' }
  validates :email, presence: true


  # 論理削除ユーザーのログイン禁止
  def active_for_authentication?
    super && self.leave_at == nil
  end


end
