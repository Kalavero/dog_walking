class CreateDogWalkings < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walkings do |t|
      t.integer :status
      t.date    :appointment_date, null: false
      t.float   :price, null: false
      t.integer :duration, null: false
      t.date    :start_time, null: false
      t.date    :end_time, null: false
      t.float   :latitude, null: false
      t.float   :longitude, null: false
      t.timestamps
    end
  end
end
