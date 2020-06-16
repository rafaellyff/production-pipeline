Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders do 
    collection do
      get 'consult_status'
      get 'consult_purchase_channel'
    end
  end

end
  
 