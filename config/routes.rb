Rails.application.routes.draw do
  get 'unitboard/:id/:challid' => 'users#unitboard', as:"unit_graph"

  get 'challenges/:id/clonechall' => 'challenges#clone_challenge'

  post ':id/preupdateunits' => "challenges#preupdate_units", as:"preupdate_units"

  get 'challenges/:id/removeunit/:unitid' => 'challenges#remove_unit'

  post 'challenges/:id/addunit' => 'challenges#add_unit'

  post ':id/updateunits' => 'challenges#update_units'

  get 'challenges/:id/editunits' => 'challenges#edit_units', as:"edit_units"

  get 'challenges/:id/categoremove/:catid' => 'challenges#remove_category'

  get 'challenges/:id/categories/:catid' => 'challenges#set_category'

  get 'challenges/redindex' => 'challenges#red_index', as:"red_index"

  post 'categories/create/:challid' => 'categories#create'

  post 'categories/update'

  post 'categories/delete'

  	root "challenges#index"

	post "challenge/join_challenge/:id", to: "challenges#join_challenge", as: "join_challenge"

        post "challenge/unjoin_challenge/:id", to: "challenges#unjoin_challenge", as: "unjoin_challenge"
  post "user/setbest" => "users#setbest", as:"setbest"


#  get "user/:id/:chid", to: "users#getchallenge", as:"getchallenge"
  get "user/:id/profile", to: "users#show", as:"profile"

	get "user/:id", to: "users#dashboard", as:"dashboard"
  post "user/:id/:challid" => "users#dashboard"
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
