Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # devise_for :users, controllers: {
  #     sessions: 'users/sessions',
  #     passwords: 'users/passwords',
  #     registrations: 'users/registrations'
  # }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   #get 'persons/edit' => "person#edit"
   resource :profile
   resources :tickets, only: [:new, :create, :index]
   # get 'tickets/journey_selection' => "ticket#journey_selection"
   # resources :tickets do
   #  get :journey_selection,  on: :member
   #  get :journey_info,       on: :member
   # end

   resources :journey do
    get :journey_selection,  on: :member
    get :journey_info,       on: :member
   end

end
