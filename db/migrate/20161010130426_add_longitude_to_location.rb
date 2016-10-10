class AddLongitudeToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :longitude, :float
  end
end
