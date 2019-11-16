Rails.application.routes.draw do

  post 'authenticate', to: 'authentication#authenticate'

  resources :carparks, only: [] do
    collection do
      get 'nearest'
    end
  end
end
