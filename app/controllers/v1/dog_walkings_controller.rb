class V1::DogWalkingsController < ApplicationController
  def index
    @dog_walkings = DogWalking.all
    json_response(@dog_walkings)
  end
end
