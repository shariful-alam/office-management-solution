Rails.application.routes.draw do

  namespace :api do

    resources :sessions do
      collection do
        put :sign_out
      end
    end

    resources :registrations

    resources :categories

    resources :allocated_leaves do
      member do
        get :show_all
      end
    end

    resources :attendances do
      collection do
        put :check_out
      end
    end

    get '/', to: 'home#index'

    resources :expenses do
      member do
        put :approve
        put :reject
      end
    end

    resources :leaves do
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

    resources :incomes do
      member do
        put :approve
        put :reject
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

  end

  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :expenses do
    member do
      put :approve
      put :reject
    end
  end

  post '/copy-budget', to: 'budgets#copy_budget', as: :copy_budget

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
