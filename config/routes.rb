Rails.application.routes.draw do
  namespace :v1 do
    resources :dog_walkings, only: [:index]
  end
end
