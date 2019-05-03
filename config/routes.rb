Rails.application.routes.draw do
	resources :users
	get    'sign_in'   => 'sessions#new'
	post   'sign_in'   => 'sessions#create'
	delete 'sign_out'  => 'sessions#destroy'
	get 'movies/pagination/', to: 'sessions#pagination'
	get 'movies/:id', to: 'sessions#show'
	get 'search', to: 'sessions#search'
	root 'sessions#new'
end