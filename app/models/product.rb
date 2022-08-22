class Product < ApplicationRecord
  belongs_to :category

  validates :name, :price, :category_id, presence: true

  def self.most_selled_products
    # CP: El objetivo era los productos más comprados no los productos que más han recaudado dinero
    #     Aun así es una buena propuesta de código para los productos que más recaudan dinero por categoría.
    #     Viendo el código sin ejecutarlo, creo que cumple.
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
