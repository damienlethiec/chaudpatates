class CreateTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :trainings do |t|
      t.text :public_description
      t.text :private_description
      t.datetime :date
      t.references :city, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
