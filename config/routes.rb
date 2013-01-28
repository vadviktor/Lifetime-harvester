LifetimeHarvester::Application.routes.draw do

  resources :tasks, :except => :new do
    member do
      get 'pause'
      get 'continue'
    end
  end

  root :to => 'tasks#index'

end
