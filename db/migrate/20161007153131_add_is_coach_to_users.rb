class AddIsCoachToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :is_coach, :boolean, :default => false
  end
end
