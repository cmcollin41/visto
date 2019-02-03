Rails.application.routes.draw do

  resources :addresses
	root "pages#index"

	get "/schedule", to: "pages#schedule", as: "schedule"
  get "/pricing", to: "pages#pricing", as: "pricing"
  get "/about", to: "pages#about", as: "about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
