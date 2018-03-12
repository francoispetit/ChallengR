Rails.application.routes.draw do

  get 'challenges/index'

  get 'challenges/show'

  get 'challenges/new'

  get 'challenges/edit'

	devise_for :users
	resources :challenges
	resources :subgoals

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
