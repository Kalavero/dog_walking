# frozen_string_literal: true

class CreateDogWalkingPets < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walking_pets do |t|
      t.integer :pet_id, null: false
      t.integer :dog_walking_id, null: false
      t.timestamps
    end
  end
end
