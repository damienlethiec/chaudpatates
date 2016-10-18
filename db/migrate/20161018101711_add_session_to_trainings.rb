class AddSessionToTrainings < ActiveRecord::Migration[5.0]
  def change
    add_reference :trainings, :session, foreign_key: true
  end
end
