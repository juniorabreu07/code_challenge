# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
  categories = []
  3.times.each do |algo|
    categories.push Category.create({ name: Faker::Name.name })
  end

  products = []
  10.times.each do |algo|
    products.push Product.create({name:Faker::Device.manufacturer, price: Faker::Number.decimal(l_digits: 2), category_id: categories.sample.id })
  end

  Buy.upsert_all(
    50000.times.map do |algo|
      product = products.sample
      quantity = Faker::Number.between(from: 1, to: 10)
      price = product.price
      total = price * quantity
      {
        product_id: product.id,
        price: price,
        total: total,
        quantity: quantity
      }
    end
  )
