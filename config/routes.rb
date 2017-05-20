Rails.application.routes.draw do
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
end
