Rails.application.routes.draw do
  
  resources :posts, only: [:index, :new, :create, :show]
  
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions'
  }

  get  'users/profile_edit' => 'users/profile_edit'
  get  'users/:id'          => 'users#show'
  
  Rails.application.routes.draw do
    resources :posts
  end
  
  devise_scope :posts do
    get '/', to: 'posts#index'
  end
  
  
end
