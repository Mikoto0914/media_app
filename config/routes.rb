Rails.application.routes.draw do
  
  resources :posts, only: [:index, :new, :create, :show] do
    resources :likes, only: [:create, :destroy]
    resources :stocks, only: [:create, :destroy]
  end
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions'
  }

  get  'users/profile_edit' => 'users#profile_edit'
  get  'users/draft'      => 'users#draft'
  get  'users/favorite'     => 'users#favorite'
  get  'users/:id'          => 'users#show'
  
  
  
  Rails.application.routes.draw do
    resources :posts
  end
  
  devise_scope :posts do
    root to: 'posts#index'
    get  '/search'          => 'posts#search'
    post 'posts/:id/post_up'  => 'posts#post_up'
  end
  
end
