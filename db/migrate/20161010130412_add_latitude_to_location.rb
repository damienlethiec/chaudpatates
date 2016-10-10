class AddLatitudeToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :latitude, :float
  end
end
