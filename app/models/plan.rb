# frozen_string_literal: true

class Plan < ApplicationRecord
  validates_presence_of :base_cost, :additional_cost, :name, :duration

  def total_cost(quantity)
    base_cost + ((quantity - 1) * additional_cost)
  end
end
