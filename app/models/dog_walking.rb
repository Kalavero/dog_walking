# frozen_string_literal: true

class DogWalking < ApplicationRecord

  DURATIONS = [30, 60].freeze
  enum status: [:scheduled, :started, :finished]

  has_many :dog_walking_pets
  has_many :pets, through: :dog_walking_pets

  validates_presence_of :appointment_date, :price, :duration, :start_date,
                        :end_date, :latitude, :longitude, :pets

  validates :duration, inclusion: { in: DURATIONS }
  scope :not_started, -> { where('start_date > ?', Time.zone.now) }


  def start_walk
    update!(status: :started, start_date: Time.zone.now)
  end

  def finish_walk
    update!(status: :finished, end_date: Time.zone.now)
  end

  def true_walk_duration
    ((end_date - start_date)/1.minutes).to_i
  end
end
