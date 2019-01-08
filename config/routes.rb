Rails.application.routes.draw do
  root :to => 'pages#home'

  resources :invitations

  get 'admin/logout' => 'admin_sessions#destroy'
end
