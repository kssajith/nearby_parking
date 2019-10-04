Rails.application.routes.draw do
  resources :carparks, only: [] do
    collection do
      get 'nearest'
    end
  end
end
