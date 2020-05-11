Rails.application.routes.draw do
  get 'posts/top' => "posts#top"
  get 'posts/index' => "posts#index"
  get 'posts/new' => "posts#new"
  post 'posts/create' => "posts#create"
  post 'posts/:id/destroy' => "posts#destroy"
  get 'posts/:id' => "posts#edit"
  post 'posts/:id/update' => "posts#update"

  get 'signup' => "users#new"
  post 'users/create' => "users#create"
  get 'login' => "users#login_form"
  post 'login' => "users#login"
  post 'logout' => "users#logout"
  get 'users/index' => "users#index"
  get 'users/:id/edit' => "users#edit"
  post 'users/:id/update' => "users#update"
  get 'users/:id' => "users#show"

  get '/' => "static_pages#home"

end
