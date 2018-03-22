Rails.application.routes.draw do

  get 'challenges/:id/categoremove/:catid' => 'challenges#remove_category'

  get 'challenges/:id/categories/:catid' => 'challenges#set_category'

  get 'challenge/:id' => 'challenges#addtargetstosubgoals', as: 'addtargetstosubgoals'

  post 'categories/create/:challid' => 'categories#create'

  post 'categories/update'

  post 'categories/delete'

  	root "challenges#index"

	post "challenge/join_challenge/:id", to: "challenges#join_challenge", as: "join_challenge"

  get "user/:id/:chid", to: "users#getchallenge", as:"getchallenge"
	get "user/:id", to: "users#dashboard", as:"dashboard"
  post "user/:id" => "users#dashboard"
#	get "user/:id", to: "users#show", as:"profile"
	devise_for :users
	resources :challenges do
		resources  :comments
	end
	resources  :comments do
		resources  :comments
	end

	resources :subgoals

        resources :conversations do
          resources :messages
        end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
