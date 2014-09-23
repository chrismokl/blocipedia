Blocipedia::Application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :collaborations, only: [:index]
  end
  resources :wikis do
    resources :articles, except: :index
    resources :collaborations, only: [:index], controller: 'wikis/collaborations'
  end
  resources :collaborations, only: [:create]

  resources :purchases, only: [:create]

  get 'about' => "welcome#about"
  get 'profile' => "users#show"
  root to: "welcome#index"
end