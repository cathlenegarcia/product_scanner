class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :product_code, null: false, index: { unique: true }
      t.string :name
      t.monetize :price

      t.timestamps
    end
  end
end
