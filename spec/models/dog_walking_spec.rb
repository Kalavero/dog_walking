require 'rails_helper'

RSpec.describe DogWalking do
  ####################
  ### Associations ###
  ####################
  describe 'associations' do
    it { should have_many(:dog_walking_pets) }
    it { should have_many(:pets).through(:dog_walking_pets) }
  end

  ###################
  ### Validations ###
  ###################
  describe 'validations' do
    it { should validate_presence_of(:appointment_date) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end
end
