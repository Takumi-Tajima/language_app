Rails.application.routes.draw do
  devise_for :instructors, controllers: { sessions: 'instructors/sessions' }, skip: [:registrations]
  devise_for :administrators, controllers: { sessions: 'administrators/sessions' }

  namespace :administrators do
    root 'home#index'
  end

  namespace :instructors do
    root 'home#index'
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
