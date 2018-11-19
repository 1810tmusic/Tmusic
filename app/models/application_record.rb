class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  validates :name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: '名前(カナ)はカタカナで入力して下さい。' }

end
