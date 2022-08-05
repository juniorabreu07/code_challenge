FactoryBot.define do
  factory :category, class: Category do
    name {"example"}
  end
  factory :random_category, class: Category do
    name { Faker::Name.name }
  end
end


