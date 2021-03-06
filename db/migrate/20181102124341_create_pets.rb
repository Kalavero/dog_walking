# frozen_string_literal: true

class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
