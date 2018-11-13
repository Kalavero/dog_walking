# frozen_string_literal: true

class CreateDogWalkings < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walkings do |t|
      t.integer :status
      t.timestamp :appointment_date, null: false
      t.float      :price, null: false
      t.integer    :duration, null: false
      t.timestamp :start_date, null: false
      t.timestamp :end_date, null: false
      t.float      :latitude, null: false
      t.float      :longitude, null: false
      t.timestamps
    end
  end
end
