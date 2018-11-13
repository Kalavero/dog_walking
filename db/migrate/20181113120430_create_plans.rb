# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.text    :name, null: false
      t.float   :base_cost, null: false
      t.float   :additional_cost, null: false
      t.integer :duration, null: false

      t.timestamps
    end
  end
end
