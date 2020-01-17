Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :expenses do
    member do
      put :approve
      put :check
    end
  end

  resources :budgets do
    member do
      put :check
    end
  end


  namespace :manage do
    resources :users do
      member do
        put :check
      end
    end
  end

  root to: 'home#index'

  resources :leaves
end
