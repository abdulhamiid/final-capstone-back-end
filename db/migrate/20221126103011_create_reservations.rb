class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :fitness_activity, null: false, foreign_key: true
      t.references :available_date, null: false, foreign_key: true
      t.timestamps
    end
  end
end
