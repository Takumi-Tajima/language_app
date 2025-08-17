Rails.application.routes.draw do
  devise_for :instructors, controllers: { sessions: 'instructors/sessions' }, skip: [:registrations]
  devise_for :administrators, controllers: { sessions: 'administrators/sessions' }

  namespace :administrators do
    root 'home#index'
    resources :instructors, only: %i[index show new edit create update destroy]
  end

  namespace :instructors do
    root 'home#index'
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
