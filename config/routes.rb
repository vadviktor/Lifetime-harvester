LifetimeHarvester::Application.routes.draw do
  resources :tasks, :except => :new do
    member do
      get 'pause'
      get 'reset'
      get 'continue'
    end
  end

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: 'sessions#auth_failure'
  match 'signout', to: 'sessions#destroy', as: 'signout'

  root :to => 'tasks#index'

end
