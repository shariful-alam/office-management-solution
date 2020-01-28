Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :expenses do
    member do
      put :approve
      put :reject
      get :search_by_date
    end
  end

  resources :budgets do
    member do
      get :search_by_date
    end
  end


  namespace :manage do
    resources :users do
      member do
        get :show_all
        get :search_by_date
        put :check
      end
    end
  end

  root to: 'home#index'

  resources :leaves do
    member do
      put :approve
    end
  end
end
