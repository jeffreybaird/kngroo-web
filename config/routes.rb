Kngroo::Application.routes.draw do

  resources :users, :only => [ :new, :create ]
  resource :user, :only => [ :show, :update, :destroy ] do
    resources :hops, :controller => 'users/hops', :only => [ :index, :show ]
    resources :assignments, :only => [ :index, :create, :destroy ] do
      resources :venues, :only => :show do
        resources :trivias, :only => [ :index ]
        resources :checkins, :only => :create
      end
    end
    resources :attempts, :only => [ :create ]
  end
  resources :sessions, :only => :new
  resource :session, :only => [ :create, :destroy ]
  match '/sign_in' => 'sessions#new', :via => :get, :as => 'sign_in'
  match '/sign_up' => 'users#new', :via => :get, :as => 'sign_up'
  match '/sign_out' => 'sessions#destroy', :via => [:get,:delete], :as => 'sign_out'
  
  resources :hops, :only => [ :create, :index, :show, :update, :destroy ] do
    resources :venues, :controller => 'hops/venues', :only => [ :index, :show, :update, :destroy ] do
      collection do
        post :search
      end
      resources :trivias, :only => [ :create, :update, :destroy ]
    end
    member do
      get :publish
    end
  end
  resources :memberships, :only => [ :create, :destroy ]
  resources :leaders, :only => [ :index ]
  resources :categories, :only => [ :index ]
  
  root :to => 'home#index'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
