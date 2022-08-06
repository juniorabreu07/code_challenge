class Product < ApplicationRecord
  belongs_to :category

  validates :name, :price, :category_id, presence: true

  def self.most_selled_products
    ActiveRecord::Base.connection.exec_query("
      select * from categories c
      join lateral (
        select p.category_id , sum(b.quantity) vendido, p.id product_id
      from buies b
      inner join products p on p.id = b.product_id
      where p.category_id = c.id
      group by p.category_id , p.id order by vendido desc limit 3

      ) p on true
      order by c.id;

    ").to_a
  end
end
