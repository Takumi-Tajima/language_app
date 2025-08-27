Rails.application.routes.draw do
  devise_for :instructors, controllers: { sessions: 'instructors/sessions' }
  devise_for :administrators, controllers: { sessions: 'administrators/sessions' }

  namespace :administrators do
    root 'instructors#index'
    resources :instructors, only: %i[index show new edit create update destroy] do
      resource :impersonation, only: %i[create destroy], module: :instructors
    end
  end

  namespace :instructors do
    root 'home#index'
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
