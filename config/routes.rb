BudgetPlanner::Application.routes.draw do
 

  
  resources :bank_transfers

  match 'accounts/:id/statement', to: 'accounts#statement', as: 'account_statement', via: [:get, :post]
  resources :accounts

  post '/reconcile_transactions/bulk_update', to: 'reconcile_transactions#bulk_update'
  resources :reconcile_transactions

  devise_for :users
  get '/users/new_user', to: 'devise#new_user_registration'
  
  resources :categories do
    resources :transactions, only: [:index]
  end
  get 'transactions/:id/edit_deposit', to: 'transactions#edit_deposit', as: 'edit_deposit_transaction'
  get '/transactions/deposit'
  resources :transactions 
  resources :fuel_statistics, only: [:index, :new, :create]
  get '/reports/summary'
  get 'reports/reset'
  resources :reports, only: [:index]
  
  resources :statements, only: [:index]
  get  '/recurring_transactions/process_recurring', to: 'recurring_transactions#process_recurring', as: 'process_recurring'
  resources :recurring_transactions

  root to: "welcome#index"


  


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
