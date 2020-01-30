Rails.application.routes.draw do

  get 'attendances/index'
  get 'attendances/show'
  get 'attendances/edit'
  get 'attendances/destroy'
  get 'attendances/new'
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

  resources :leaves do
    member do
      put :check
      put :approve
      put :reject
    end
  end

  resources :allocated_leaves do
    member do
      get :show_all
    end
  end

  resources :attendances


end
