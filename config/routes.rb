Rails.application.routes.draw do
  resources :invitations

  get 'admin' => 'admin_sessions#new_session'
end
