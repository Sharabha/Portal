Competitor::Application.routes.draw do

  get "user_team_membership/new"

  get "user_team_membership/destroy"

  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:index]

  resources :teams do
   resources :invitations
   resources :users, :only => [:index] do
     resources :user_team_memberships
   end
  end

  resources :problems do
    resources :guardian_memberships
  end

  resources :competitions do
    resources :judge_memberships, :except => [:index, :edit, :update]
    resources :team_memberships, :except => [:index, :edit, :update]
    resources :problem_memberships do
      resources :solutions, :except => [:index]
      resources :guardian_memberships, :except => [:index, :edit, :update]
    end
    member do
      put "close"
    end
  end

  namespace :admin do
    root :to => 'users#show'
    resources :users, :only => [:index, :edit, :update, :destroy]
    resources :problems
    resources :competitions do
      resources :judge_memberships, :except => [:index, :edit, :update]
      resources :team_memberships, :except => [:index, :edit, :update]
      resources :problem_memberships do
        resources :solutions, :except => [:index]
        resources :guardian_memberships, :except => [:index, :edit, :update]
      end

      member do
        put "close"
      end
    end
  end

  match 'confirm/:token' => 'invitations#confirm'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
