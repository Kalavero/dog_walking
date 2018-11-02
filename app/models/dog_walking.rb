class DogWalking < ApplicationRecord
  has_many :dog_walking_pets
  has_many :pets, through: :dog_walking_pets

  validates_presence_of :appointment_date, :price, :duration, :start_time,
                        :end_time, :latitude, :longitude
end
