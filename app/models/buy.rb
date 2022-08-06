class Buy < ApplicationRecord
  belongs_to :product
  validates :price, :total, :quantity, :product_id, presence: true

  def self.buies_by_filters(filters)
    date_from        = Time.parse( filters[:date_from] ).beginning_of_day rescue Time.zone.now.beginning_of_day
    date_to          = Time.parse( filters[:date_to] ).end_of_day rescue Time.zone.now.end_of_day
    where_date_range = " buies.created_at between :date_from and :date_to"

    where_product_id   = "and products.id = :product_id" unless filters[:product_id].blank?
    where_product_name = "and lower(products.name) like :product_name" unless filters[:product_name].blank?

    where_category_id   = "and categories.id = :category_id" unless filters[:category_id].blank?
    where_category_name = "and lower(categories.name) like :category_name" unless filters[:category_name].blank?
    params = {
      product_id: filters[:product_id],
      category_id: filters[:category_id],
      date_from: date_from.to_s,
      date_to: date_to.to_s,
      product_name: "%#{filters[:product_name]&.downcase}%",
      category_name: "%#{filters[:category_name]&.downcase}%"
    }
    query = ActiveRecord::Base.send(:sanitize_sql_array, ["
      select buies.*
      from buies
      inner join products   ON products.id = buies.product_id
      inner join categories ON categories.id = products.category_id
    where
      #{where_date_range}
      #{where_product_id}
      #{where_product_name}
      #{where_category_id}
      #{where_category_name}
    ", params])
    ActiveRecord::Base.connection.exec_query(query).to_a
  end
end
