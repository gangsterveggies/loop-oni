Loop::Application.routes.draw do
  get "email_validations/edit"
  get "email_validations/update"
  resources :users
  resources :articles
  resources :contests
  resources :guides
  resources :problems
  resources :posts, only: [:new, :edit, :update, :create, :show, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :email_validations, only: [:edit]
  resources :announcements, only: [:new, :create, :edit, :update, :index, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :read_relationships, only: [:create, :destroy]
  resources :participate_relationships, only: [:create, :destroy]
  resources :guide_relationships, only: [:create, :destroy]
  resources :guide_relationships do
    collection { post :sort }
  end

  get 'problem_types/:problem_tag',   to: 'problems#index', as: :problem_tag
  get 'problem_types/',               to: 'problem_tags#index'
  get 'categories/:article_tag',      to: 'articles#index', as: :article_tag
  get 'categories/',                  to: 'article_tags#index'
  root  'cover_pages#home'
  match '/password_resets/:id', to: 'password_resets#edit',          via: 'get', :as => 'make_password_reset'
  match '/email_validation/:id',to: 'email_validations#edit',        via: 'get', :as => 'make_email_validation'
  match '/hide_announcement',   to: 'javascripts#hide_announcement', via: 'get'
  match '/signup',              to: 'users#new',                     via: 'get'
  match '/signin',              to: 'sessions#new',                  via: 'get'
  match '/signout',             to: 'sessions#destroy',              via: 'delete'
  match '/admin',               to: 'admin#panel',                   via: 'get'
  match '/gen_contest',         to: 'admin#gen_contest_tool',        via: 'get'
  match '/help',                to: 'cover_pages#help',              via: 'get'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
