class CreateAvailableDates < ActiveRecord::Migration[7.0]
  def change
    create_table :available_dates do |t|
      t.references :fitness_activity, null: false, foreign_key: true
      t.date :date
      t.boolean :reserved, default: false
      t.timestamps
    end
  end
end
