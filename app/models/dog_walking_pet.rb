class DogWalkingPet < ApplicationRecord
  belongs_to :pet
  belongs_to :dog_walking
end
