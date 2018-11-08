# frozen_string_literal: true

class V1::DogWalkingsController < ApplicationController
  before_action :set_dog_walking, only: [:show]

  def index
    if params[:not_started]
      @dog_walkings = DogWalking
        .order(:appointment_date)
        .not_started
        .page(params[:page])
        .per(params[:per_page])
    else
      @dog_walkings = DogWalking.page(params[:page]).per(params[:per_page])
    end

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
