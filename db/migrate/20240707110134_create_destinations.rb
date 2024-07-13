class CreateDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :destinations do |t|
      t.string     :post_code,            null: false
      t.integer    :shipping_source_id,    null: false
      t.string     :municipality,           null: false
      t.string     :street_address,         null: false
      t.string     :building_name
      t.string     :tel,                    null: false
      t.references :purchase,               null: false, foreign_key: true
      t.timestamps
    end
  end
end
