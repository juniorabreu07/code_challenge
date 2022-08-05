class Buy < ApplicationRecord
  belongs_to :product
  validates :price, :total, :quantity, :product_id, presence: true

end
