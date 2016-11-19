class CreateOutwardApprovals < ActiveRecord::Migration
  def change
    create_table :outward_approvals do |t|
      t.datetime :dispatch_date
      t.string :patry_name
      t.datetime :billing_date
      t.integer :status
      t.integer :outward_id
      t.boolean :isactive

      t.timestamps null: false
    end
  end
end
