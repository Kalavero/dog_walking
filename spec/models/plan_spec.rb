# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plan, type: :model do
  ###################
  ### Validations ###
  ###################
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:base_cost) }
    it { should validate_presence_of(:additional_cost) }
    it { should validate_presence_of(:duration) }
  end

  describe 'total_cost' do
    it 'returns the total cost of a plan based on the quantity provided' do
      plan = create(:plan, base_cost: 25.00, additional_cost: 15.00)

      expect(plan.total_cost(2)).to eq(40.00)
    end
  end
end
