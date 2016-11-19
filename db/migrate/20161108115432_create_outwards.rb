class CreateOutwards < ActiveRecord::Migration
  def change
    create_table :outwards do |t|
      t.integer :truck_number
      t.integer :outward_number
      t.datetime :outward_date
      t.integer :location_id
      t.integer :dispatch_type
      t.integer :total_quantity
      t.integer :payment_type
      t.integer :warehouse_id
      t.boolean :isactive
      t.integer :created_by
      t.integer :updated_by

      t.timestamps null: false
    end
  end
end
