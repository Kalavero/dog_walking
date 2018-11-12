# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    resources :dog_walkings, only: %i[index show create] do
      member do
        put :start_walk
        put :finish_walk
      end
    end
  end
end
