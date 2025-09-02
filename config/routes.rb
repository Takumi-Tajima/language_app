Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :instructors, controllers: { sessions: 'instructors/sessions' }
  devise_for :administrators, controllers: { sessions: 'administrators/sessions' }

  devise_scope :instructor do
    get 'instructors/edit' => 'instructors/registrations#edit', as: 'edit_instructor_registration'
    put 'instructors' => 'instructors/registrations#update', as: 'instructor_registration'
  end

  namespace :administrators do
    root 'instructors#index'
    resources :instructors, only: %i[index show new edit create update destroy] do
      resource :impersonation, only: %i[create destroy], module: :instructors
    end
  end

  namespace :instructors do
    root 'lessons#index'
    resource :profile, only: %i[show edit update]
    resources :lessons, only: %i[index show new edit create update destroy] do
      resources :lesson_schedules, only: %i[index show new edit create update destroy], module: :lessons
    end
  end

  namespace :users do
    root 'home#index'
    resources :purchases, only: %i[show new]
    resources :stripe_checkouts, only: %i[create] do
      collection do
        get 'success'
      end
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
