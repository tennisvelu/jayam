class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :outward_approvals, :patry_name, :party_name 
  end
end
