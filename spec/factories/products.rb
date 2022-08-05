FactoryBot.define do
  factory :product, class: Product do
    name {"example"}
  end
  factory :random_product, class: Product do
    category_id {1}
    name { Faker::Name.name }
    price { Faker::Number.decimal(l_digits: 2) }
  end
end
