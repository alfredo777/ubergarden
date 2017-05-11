Rails.application.routes.draw do
  root 'tienda#index'
  get 'all_items', to: 'tienda#productos', as: :all_items
  get 'tienda/search'
  get 'item-in-stock/:id', to: 'tienda#producto', as: :item
  get 'tienda/carrito'
  get 'tienda/confirmacion_pago'

  devise_for :users

  resources :products, path: 'admin/products'
  
  get 'admin/products/:id/products_photos',to: 'products#products_photos', as: :gallery
  get 'admin/products/:id/add_photos',to: 'products#add_photos', as: :add_photos
  post 'admin/products/:id/add_photos',to: 'products#add_photos'
  get 'admin/products_import_list', to: 'products#import_list', as: :import_list
  get 'admin/categoria-de-producto', to: 'products#categoria', as: :categoria
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
