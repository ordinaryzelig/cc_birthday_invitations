Rails.application.routes.draw do
  root :to => 'pages#home'

  resources :invitations, :only => %i[index show edit update new create]

  get 'admin/logout' => 'admin_sessions#destroy', :as => :logout_admin
end
