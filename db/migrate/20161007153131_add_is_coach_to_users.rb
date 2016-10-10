class AddIsCoachToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_coach, :boolean, :default => false
  end
end
