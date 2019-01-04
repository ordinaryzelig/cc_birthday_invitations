Rails.application.routes.draw do
  root :to => 'pages#home'

  resources :invitations

  get 'admin' => 'admin_sessions#new_session'
end
