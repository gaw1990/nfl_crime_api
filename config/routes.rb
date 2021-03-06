Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do 
    namespace :v1 do 
      resources :crimes, only: [:index, :show]
      resources :players, only: [:index, :show]
      get '/top_players', to: "players#top"
      resources :teams, only: [:index, :show]
      resources :positions, only: [:index, :show]
      resources :crime_categories, only: [:index, :show]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
