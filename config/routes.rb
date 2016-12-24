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
  get 'companies/id_pass_warehouse'
  post 'companies/id_pass_warehouse'
  get 'companies/grade'
  post 'companies/grade_save'
  get 'companies/grade_edit'
  get 'companies/grade_delete'
  post 'companies/grade_update'
  get 'companies/packing'
  post 'companies/packing_save'
  get 'companies/packing_edit'
  get 'companies/packing_delete'
  post 'companies/packing_update'
  post 'companies/inward_consolidate'
  resources :companies

  get 'users/login_page'
  put 'users/validate_login'
  get 'users/logout'
  get 'users/dynamic_warehouse'
  post 'users/dynamic_warehouse'
  resources :users

  get 'warehouses/warehouse_admin'
  post 'warehouses/warehouse_admin'
  post 'warehouses/damage_entry'
  post 'warehouses/inward_date'
  post 'warehouses/outward_date'
  post 'warehouses/damage_date'
  post 'warehouses/direct_sale'
  post 'warehouses/inward_consolidate'
  post 'warehouses/approve_reject_report'  
  resources :warehouses
  # The priority is based upon order of creation: first created -> highest priority.
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'inwards/warehouse_identification'
      get 'inwards/inward_identification'
      put 'inwards/total_quantity_update'
      post 'inward_manufacture_details/bulk_create'
      resources :inwards 
      get 'warehouse_id'
      resources :inward_manufacture_details
      put 'outwards/total_quantity_update'
      put 'outwards/status_update'
      put 'outwards/outward_update'
      resources :outwards
      post 'outward_manufacture_details/outward_id_detail'
      put 'outward_manufacture_details/balance_update'
      post 'outward_manufacture_details/outward_manufacture_detail'
      resources :outward_manufacture_details
      resources :warehouses
      post 'users/application_login'
      resources :users
      resources :locations
      put 'outward_approvals/billing_date_update'
      put 'outward_approvals/outward_approval_total_update'
      put 'outward_approvals/outward_approval_status_update'
      resources :outward_approvals
      post 'grades/company_id'
      resources :grades
      post 'packings/company_id'
      resources :packings
      resources :loading_types
      post 'damages/bulk_create'
      post'damages/damage_stock'
      resources :damages
      post 'approval_grade_details/approval_id'
      put 'approval_grade_details/balance_update'
      put 'approval_grade_details/advance_dispatch'
      resources :approval_grade_details
      post 'stocks/warehouse_stock'
      resources :stocks
      resources :roles

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
