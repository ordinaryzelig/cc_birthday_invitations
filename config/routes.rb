Rails.application.routes.draw do
  root :to => 'pages#home'

  resources :invitations, :only => %i[index show edit update new create] do
    resources :song_requests, :only => %i[create destroy]
  end
end
