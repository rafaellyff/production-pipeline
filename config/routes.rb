Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get 'orders', to: 'orders#index'
  post 'orders', to: 'orders#create'
  get 'orders/consult_status'
  get 'orders/consult_pipeline'

  post 'batches', to: 'batches#create'
  put 'batches/update_status/:id', to: 'batches#update_status'
end
  
 