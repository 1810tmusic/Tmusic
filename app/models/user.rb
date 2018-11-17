class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  acts_as_paranoid column: :leave_at

  has_many :destinations
  has_many :posts
  has_many :post_products, through: :posts, source: :product
  has_many :carts


end
