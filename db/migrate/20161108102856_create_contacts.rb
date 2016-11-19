class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.integer :telephone_number
      t.integer :mobile_number

      t.timestamps null: false
    end
  end
end
