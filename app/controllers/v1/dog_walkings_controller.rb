# frozen_string_literal: true

class V1::DogWalkingsController < ApplicationController
  before_action :set_dog_walking, only: %i[show start_walk finish_walk]

  def index
    @dog_walkings = if params[:not_started]
                      DogWalking
                        .order(:appointment_date)
                        .not_started
                        .page(params[:page])
                        .per(params[:per_page])
                    else
                      DogWalking.page(params[:page]).per(params[:per_page])
                    end

    json_response(@dog_walkings)
  end

  def show
    @dog_walking.duration = @dog_walking.true_walk_duration
    json_response(@dog_walking)
  end

  def create
    @pets = Pet.where(id: pet_ids)
    @dog_walking = DogWalking.create!(create_params.merge(price: 0.0,
                                                          pets: @pets))

    json_response(@dog_walking, :created)
  end

  def start_walk
    @dog_walking.start_walk

    head :ok
  end

  def finish_walk
    @dog_walking.finish_walk

    head :ok
  end

  private

  def set_dog_walking
    @dog_walking = DogWalking.find(params[:id])
  end

  def create_params
    params
      .require(:dog_walking)
      .permit(:appointment_date,
              :duration,
              :start_date,
              :end_date,
              :latitude,
              :longitude)
  end

  def pet_ids
    params.require(:dog_walking).permit(pet_ids: [])[:pet_ids]
  end
end
