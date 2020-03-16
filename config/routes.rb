Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get '/' => 'posts#index'
  
  get  'posts/new'        => 'posts#new'
  get  'posts/:id'        => 'posts#show'
  post 'posts/create'     => 'posts#create'
  get  'posts/:id/edit'   => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'
  get  'users/profile_edit'=>  'users/profile_edit'
  get  'users/:id'         => 'users#show'
  
end
