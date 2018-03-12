Rails.application.routes.draw do

  	root "challenges#index"

	devise_for :users
	resources :challenges
	resources :subgoals

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
