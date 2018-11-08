# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DogWalkingPet do
  describe 'associations' do
    it { should belong_to(:pet) }
    it { should belong_to(:dog_walking) }
  end
end
