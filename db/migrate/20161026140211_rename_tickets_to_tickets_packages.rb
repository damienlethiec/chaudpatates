class RenameTicketsToTicketsPackages < ActiveRecord::Migration[5.0]
  def change
  	add_column :tickets, :tickets_nb, :integer
  	rename_table :tickets, :tickets_packages
  end
end
