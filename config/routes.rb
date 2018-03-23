Rails.application.routes.draw do

  post ':id/preupdateunits' => "challenges#preupdate_units", as:"preupdate_units"

  get 'challenges/:id/removeunit/:unitid' => 'challenges#remove_unit'

  post 'challenges/:id/addunit' => 'challenges#add_unit'

  post ':id/updateunits' => 'challenges#update_units'

  get 'challenges/:id/editunits' => 'challenges#edit_units', as:"edit_units"

  get 'challenges/:id/categoremove/:catid' => 'challenges#remove_category'

  get 'challenges/:id/categories/:catid' => 'challenges#set_category'

  post 'categories/create/:challid' => 'categories#create'

  post 'categories/update'

  post 'categories/delete'

  	root "challenges#index"
		get 'challenges/redindex' => 'challenges#red_index'

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
