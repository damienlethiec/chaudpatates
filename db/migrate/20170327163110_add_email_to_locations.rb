class AddEmailToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :public_description, :text
  end
end
