Rails.application.routes.draw do

  get 'companies/super_admin'
  post 'companies/super_admin'
  get 'companies/location_approve'
  post 'companies/location_approve'
  get 'companies/suspense_advance_approve'
  post 'companies/suspense_advance_approve'
  post 'companies/damage_date'
  post 'companies/return_date'
  post 'companies/approve_reject_report'
  post 'companies/direct_sale'

  resources :companies

  get 'users/login_page'
  put 'users/validate_login'
  get 'users/logout'
  resources :users
  get 'warehouses/warehouse_admin'
  post 'warehouses/warehouse_admin'
  post 'warehouses/damage_entry'
  post 'warehouses/inward_date'
  post 'warehouses/outward_date'
  post 'warehouses/damage_date'
  post 'warehouses/direct_sale'
  resources :warehouses
  # The priority is based upon order of creation: first created -> highest priority.
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'inwards/warehouse_identification'
      get 'inwards/inward_identification'
      put 'inwards/total_quantity_update'
      resources :inwards 
      get 'warehouse_id'
      resources :inward_manufacture_details
      put 'outwards/total_quantity_update'
      resources :outwards
      post 'outward_manufacture_details/outward_id_detail'
      resources :outward_manufacture_details
      resources :warehouses
      post 'users/application_login'

      resources :users
      resources :locations
      post 'outward_approvals/outward_id'
      resources :outward_approvals
    end
  end
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 
   root :to => "users#login_page"

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
