# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DogWalking do
  include ActiveSupport::Testing::TimeHelpers
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
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:pets)}

    it 'allows only 30 and 60 minutes durations' do
      dog_walking = build(:dog_walking, duration: 45, pets: [create(:pet)])

      dog_walking.save

      expect(dog_walking.errors.messages)
        .to eq(duration: ['is not included in the list'])
    end
  end

  ##############
  ### Scopes ###
  ##############
  describe '.not_started' do
    it 'returns all dog_walkings that have not started yet' do
      pet = create(:pet)
      not_started_walking = create(:dog_walking,
                                   start_date: Time.zone.now + 30.minutes,
                                   appointment_date: Date.today,
                                   pets: [pet])

      create(:dog_walking,
             start_date: Time.zone.now - 30.minutes,
             appointment_date: Date.today,
             pets: [pet])

      expect(described_class.not_started).to eq([not_started_walking])
    end
  end
  ###############
  ### Methods ###
  ###############
  describe '#start_walk' do
    it 'updates the status and start_date' do
      dog_walking = create(:dog_walking, pets: [create(:pet)])

      allow(dog_walking).to receive(:update!)

      freeze_time

      dog_walking.start_walk

      expect(dog_walking).to have_received(:update!)
        .with(status: :started, start_date: Time.zone.now)
    end
  end

  describe '#finish_walk' do
    it 'updates the status and end_date' do
      dog_walking = create(:dog_walking, pets: [create(:pet)])

      allow(dog_walking).to receive(:update!)

      freeze_time

      dog_walking.finish_walk

      expect(dog_walking).to have_received(:update!)
        .with(status: :finished, end_date: Time.zone.now)
    end
  end

  describe 'true_walk_duration' do
    it 'returns the true duration of the walk in minutes' do
      dog_walking = create(:dog_walking,
                           pets: [create(:pet)],
                           start_date: Time.now - 42.minutes,
                           end_date: Time.now)

      expect(dog_walking.true_walk_duration).to eq(42)
    end
  end
end
