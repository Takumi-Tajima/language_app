Rails.application.routes.draw do
  devise_for :instructors
  devise_for :administrators, controllers: { sessions: 'administrators/sessions' }

  namespace :administrators do
    root 'home#index'
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
