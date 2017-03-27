class AddPrivateDescriptionToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :private_description, :text
  end
end
