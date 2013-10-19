Goalsapp::Application.routes.draw do
  resources :users
  resource :session, :only => [:new, :create, :destroy]
  resources :goals do
    resources :cheers, :only => [:create]
  end
end
