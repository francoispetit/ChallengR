Rails.application.routes.draw do

<<<<<<< HEAD
  get 'categories/create'

  get 'categories/update'

  get 'categories/delete'

  	root "challenges#index"
		get 'challenges/redindex' => 'challenges#red_index'
=======
	root "challenges#index"
	get 'challenges/redindex' => 'challenges#red_index'
>>>>>>> 41e602704de6bd7fbbe44e2eed42b61182da48a8

	post "challenge/join_challenge/:id", to: "challenges#join_challenge", as: "join_challenge"

	get "user/:id", to: "users#show", as:"profile"
	devise_for :users
	resources :challenges do
		resources  :comments
	end
	resources  :comments do
		resources  :comments
	end

	resources :subgoals
        resources :categories

        resources :conversations do
          resources :messages
        end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
