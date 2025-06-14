class CreateBaskets < ActiveRecord::Migration[8.0]
  def change
    create_table :baskets, id: :uuid do |t|
      t.monetize :total_price

      t.timestamps
    end
  end
end
