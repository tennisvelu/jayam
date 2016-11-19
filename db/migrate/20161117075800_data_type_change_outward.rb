class DataTypeChangeOutward < ActiveRecord::Migration[5.0]
  def change
   change_table :outwards do |t|
      t.change :truck_number, :string
      t.change :outward_number, :string
  end
end
end
