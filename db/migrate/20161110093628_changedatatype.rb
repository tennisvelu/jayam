class Changedatatype < ActiveRecord::Migration[5.0]
  def change
   change_table :contacts do |t|
      t.change :telephone_number, :string
      t.change :mobile_number, :string
    end
  end
end
