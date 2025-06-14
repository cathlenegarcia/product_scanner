class CreateBasketItems < ActiveRecord::Migration[8.0]
  def change
    create_table :basket_items, id: :uuid do |t|
      t.references :basket, null: false, foreign_key: true, type: :uuid
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.integer :quantity

      t.timestamps
    end

    add_index :basket_items, [:basket_id, :product_id], unique: true
  end
end
