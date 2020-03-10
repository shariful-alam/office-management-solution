Rails.application.routes.draw do


  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', defaults: {format: 'json'}
    end
    resources :expenses do
      member do
        put :approve
        put :reject
      end
    end
  end

  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :expenses do
    member do
      put :approve
      put :reject
    end
  end

  resources :budgets do
    collection do
      get :show_all_expenses
      get :show_all
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
  resources :categories

  resources :incomes do
    member do
      put :approve
      put :reject
    end
  end

end
