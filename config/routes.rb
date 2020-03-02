Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :expenses do
    member do
      put :approve
      put :reject
    end
  end

  resources :budgets do
    member do
      get :show_all_expenses
    end
  end

  namespace :manage do
    resources :users do
      collection do
        get :show_all_pending
      end
      member do
        get :show_all_expenses
        get :show_all_incomes
      end
    end
  end

  root to: 'home#index'

  resources :leaves do
    member do
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

  resources :incomes do
    member do
      put :approve
      put :reject
    end
  end

end
