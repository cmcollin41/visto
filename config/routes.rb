Rails.application.routes.draw do

  root "pages#index"


  resources :questions do
    resources :choices
  end

  resources :reports do
    resources :responses
  end
  
  resources :properties

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: "admins/registrations"
  }

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: "customers/registrations"
  }

  devise_scope :customer do
    post "/signup", to: "customers/registrations#create"
  end


  post "/payments-customer", to: "payments#customer"
  post "/payments-charge", to: "payments#charge"


  
  resources :jobs
  resources :addresses
  get "/profile", to: "pages#profile", as: "profile"
	get "/schedule", to: "pages#schedule", as: "schedule"
  get "/pricing", to: "pages#pricing", as: "pricing"
  get "/about", to: "pages#about", as: "about"
  get "/inspection", to: "pages#inspection", as: "inspection"

  get "/images", to: "reports#images", as: "images"
  get "/form", to: "reports#form", as: "form"


  delete "/delete_image", to: "reports#delete_image", as: "delete_image"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
