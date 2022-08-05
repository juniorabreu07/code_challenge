class CreateBuies < ActiveRecord::Migration[7.0]
  def change
    create_table :buies do |t|

      t.references :product, null: false, foreign_key: true
      t.float :price, null: false
      t.float :total, null: false
      t.integer :quantity, null: false
      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE buies
      ADD CONSTRAINT buies_check
      CHECK (
        ((quantity is NOT null)  and (quantity > 0))
        or
        ((price is not null ) and ( price > 0))
      );
    SQL
  end
end
