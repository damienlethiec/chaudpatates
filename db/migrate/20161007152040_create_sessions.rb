class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.integer :day
      t.time :time_of_day
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
