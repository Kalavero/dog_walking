# frozen_string_literal: true

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

  ##############
  ### Scopes ###
  ##############
  describe '.not_started' do
    it 'returns all dog_walkings that have not started yet' do
      not_started_walking = create(:dog_walking,
                                   start_time: Time.zone.now + 30.minutes,
                                   appointment_date: Date.today)

      create(:dog_walking,
             start_time: Time.zone.now - 30.minutes,
             appointment_date: Date.today)

      expect(described_class.not_started).to eq([not_started_walking])
    end
  end
end
