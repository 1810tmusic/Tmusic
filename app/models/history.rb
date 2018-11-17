class History < ApplicationRecord
  enum shipping_status: { "発送準備中": 0, "発送中": 1, "発送済み": 2}
  belongs_to :cart
  belongs_to :user
end
