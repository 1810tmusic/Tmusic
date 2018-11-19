class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :destinations, foreign_key: "user_id"
  has_many :posts, foreign_key: "user_id"
  has_many :post_products, through: :posts, source: :product
  has_many :carts, foreign_key: "user_id"
  has_many :histories, foreign_key: "user_id"

  validates :name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: '名前(カナ)はカタカナで入力して下さい。' }


  # 論理削除ユーザーのログイン禁止
  def active_for_authentication?
    super && self.leave_at == nil
  end


end
