Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'

  resources :pages do
    collection do
      get :deleted # <= this
    end

    resources :versions, only: [:destroy] do
      member do
        get :diff, to: 'versions#diff'
        patch :rollback, to: 'versions#rollback'
      end
    end
  end

  resources :versions, only: [] do
    member do
      patch :bringback  # <= and that
    end
  end

end
