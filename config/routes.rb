Rails.application.routes.draw do
  get 'reserve_events/:instrument_id', to: "reserve_events#index", as: "reserve_events"
  get 'reserve_events/:instrument_id/new', to: "reserve_events#new", as: "new_reserve_event"
  get 'reserve_events/:id/:instrument_id', to: "reserve_events#show", as: "reserve_event"
  get 'reserve_events/:id/:instrument_id/edit', to: "reserve_events#edit", as: "edit_reserve_event"
  post "reserve_events/:instrument_id", to: "reserve_events#create", as: "create_reserve_event"
  get "get_koume.json", to: "reserve_events#get_koume_tweet", as: "get_koume"
  patch 'reserve_events/:id/:instrument_id', to: "reserve_events#update", as: "update_reserve_event"

  post 'current_reserve_event/cancel/:instrument_id', to: 'current_reserve_events#cancel', as: "cancel_current_reserve_event"
  root to: "home#index"
  devise_for :instruments

  namespace :api do
    namespace :v1 do
      post 'check_condition', to: "pauling#check_resevation_condition"
      post 'complete_execution', to: "pauling#complete_resevation_condition"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
