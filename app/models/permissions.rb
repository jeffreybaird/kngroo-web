class Permissions < Aegis::Permissions

  role :user
  role :admin

  resources :hops do
    allow :admin
  end

  resources :users do
    allow :admin
  end

end
