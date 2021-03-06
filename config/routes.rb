Competitor::Application.routes.draw do

  resources :posts
  match 'competitions/:competition_posts/posts' => 'Posts#index', :as => 'competition_posts'

  get "user_team_membership/new"

  get "user_team_membership/destroy"

  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:index]

  resources :invitations, :only => [:index]
  match 'confirm/:token/:answer' => 'invitations#confirm', :as => :invitation_confirm

  resources :teams do
    resources :invitations, :only => [:new, :create]
    resources :user_team_memberships, :only => [:destroy]
    member do
      put :change_leader
    end
  end

  resources :competitions, :only => [:index, :show]

  namespace :admin do
    root :to => 'users#index'
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
        get 'judges'
        get 'ranking'
        get 'problems'
        get 'teams'
      end
    end
  end


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
