class CreateFitnessActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :fitness_activities do |t|
      t.string :name
      t.string :description
      t.integer :amount
      t.timestamps
    end
  end
end
