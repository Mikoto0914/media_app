Rails.application.routes.draw do
  
  devise_for :users

<<<<<<< HEAD
=======

>>>>>>> develop
  get '/' => 'posts#index'
  
  get  'posts/new'        => 'posts#new'
  get  'posts/:id'        => 'posts#show'
  post 'posts/create'     => 'posts#create'
  get  'posts/:id/edit'   => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'
  get  'users/:id'         => 'users#show'
  
  
<<<<<<< HEAD
=======
  devise_for :users, skip: :all
  devise_scope :user do
    get    'login'              => 'devise/sessions#new',          as: :new_user_session
    post   'login'              => 'devise/sessions#create',       as: :user_session
    delete 'logout'             => 'devise/sessions#destroy',      as: :destroy_user_session
    get    'signup'             => 'devise/registrations#new',     as: :new_user_registration
    post   'signup'             => 'devise/registrations#create',  as: :user_registration
    delete 'signup'             => 'devise/registrations#destroy', as: :destroy_user_registration
    put    'signup'             => 'devise/registrations#update',  as: :update_user_registration
    get    'signup/cancel'      => 'devise/registrations#cancel',  as: :cancel_user_registration

    patch  'user/profile'       => 'devise/registrations#update',  as: nil
    get    'user/password'      => 'devise/passwords#new',         as: :new_user_password
    post   'user/password'      => 'devise/passwords#create',      as: :user_password
    get    'user/password/edit' => 'devise/passwords#edit',        as: :edit_user_password
    patch  'user/password'      => 'devise/passwords#update'
    put    'user/password'      => 'devise/passwords#update',      as: :update_user_password

  end
>>>>>>> develop
end
