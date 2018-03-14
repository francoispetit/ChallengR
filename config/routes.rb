Rails.application.routes.draw do

  	root "challenges#index"

	post "challenge/join_challenge/:id", to: "challenges#join_challenge", as: "join_challenge"

	get "user/:id", to: "users#show"
	devise_for :users
	resources :challenges do
		resources  :comments
	end
	resources  :comments do
		resources  :comments
	end

	resources :subgoals

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
