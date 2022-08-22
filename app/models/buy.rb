class Buy < ApplicationRecord
  belongs_to :product
  validates :price, :total, :quantity, :product_id, presence: true

  def self.buies_by_filters(filters)
    # CP: Para los parses ideal un Time.zone.parse.
    #     Como planteaste el filtro de fechas está bien, eso sí no me gusta la sintaxis, en general.
    #     Esperaría algo como Buy.where("buies.created_at between ? AND ?", date_from, date_to)
    #     Tampoco veo índices para optimizar la query, solo en producto.
    #
    #     Mejor es plantear el filtro por fecha(date)
    #     Buy.where("date(created_at) between ? AND ?", date_from.to_date, date_to.to_date)
    #     Teniéndo índice en la tabla buies con la expresión "date(created_at)".
    #     El desafío de este enfoque es la zona horaria que aparentemente se pierde y puede dar error, pero te lo dejo ya como desafío personal.
    date_from        = Time.parse( filters[:date_from] ).beginning_of_day rescue Time.zone.now.beginning_of_day
    date_to          = Time.parse( filters[:date_to] ).end_of_day rescue Time.zone.now.end_of_day
    where_date_range = " buies.created_at between :date_from and :date_to"

    # CP: Si cada buy ya tiene el product_id, no veo necesidad del join.
    where_product_id   = "and products.id = :product_id" unless filters[:product_id].blank?
    # CP: Si estás comparando lower con downcase para qué el like y no solo un =?
    where_product_name = "and lower(products.name) like :product_name" unless filters[:product_name].blank?

    # CP: Lo mismo que producto, no hay necesidad de join si solo filtro por category_id.
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
    # CP: Si bien ha veces esta sintaxis ayuda harto, no veo la necesidad de implementarla acá.
    #     Hay un patrón de rails que se llama Query que te permite hacer cosas como estás:
    #
    #     BuyQuery.between_dates(*filters.values_at(:from_date, :to_date))
    #             .for_product_id(filters[:product_id])
    #             .for_product_name(filters[:product_name])
    #             .for_category_id(filters[:category_id])
    #             .for_category_name(filters[:category_name])
    #
    # Así, las funciones se definen algo así, dentro de ByuQuery:
    #
    #     def for_product_id(id)
    #       self.where(product_id: id) if id.present?
    #       self
    #     end
    #
    # La función queda más limpia y sirve para poder definir los índices que necesitas.
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
    
    # CP: Hay que mejorar:
    # 1. Legibilidad de código
    # 2. Performance:
    #   2.1 Ausencia de índices
    #   2.2 Joins innecesarios: Las compras al ser info transaccional lo mejor es registrar product_id y product_name por cada compra para evitar joins.
    # 3. Me faltó ver implementación de paginación.
    #
    # Son cosas de fácil adopción creo yo, buen trabajo.
  end
end
