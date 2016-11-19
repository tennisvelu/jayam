class CreateInwards < ActiveRecord::Migration
  def change
    create_table :inwards do |t|
      t.integer :truck_number
      t.integer :inward_number
      t.datetime :inward_date
      t.integer :damage_bags_count
      t.boolean :return
      t.integer :total_quantity
      t.integer :warehouse_id
      t.boolean :isactive
      t.integer :created_by
      t.integer :updated_by

      t.timestamps null: false
    end
  end
end
