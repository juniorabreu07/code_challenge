FactoryBot.define do
  factory :buy, class: Buy do
    price {10.0}
    total {10.0}
    quantity {1}
  end

  factory :random_buy, class: Buy do
    product_id {1}
    price {Faker::Number.decimal(l_digits: 2)}
    total {10.0}
    quantity {1}
  end
end



