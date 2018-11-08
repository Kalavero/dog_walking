# frozen_string_literal: true

class V1::DogWalkingsController < ApplicationController
  before_action :set_dog_walking, only: [:show]

  def index
    @dog_walkings = params[:not_started] ? DogWalking.not_started : DogWalking.all

    json_response(@dog_walkings)
  end

  def show
    json_response(@dog_walking)
  end

  private

  def set_dog_walking
    @dog_walking = DogWalking.find(params[:id])
  end
end
