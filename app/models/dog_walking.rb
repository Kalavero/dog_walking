# frozen_string_literal: true

class DogWalking < ApplicationRecord
  has_many :dog_walking_pets
  has_many :pets, through: :dog_walking_pets

  validates_presence_of :appointment_date, :price, :duration, :start_time,
                        :end_time, :latitude, :longitude

  scope :not_started, -> { where('(appointment_date = ? AND start_time > ?) OR appointment_date > ?', Date.today, Time.zone.now, Date.today ) }
end
