Rails.application.routes.draw do
  root 'tienda#index'
  get 'all_items', to: 'tienda#productos', as: :all_items
  get 'search', to: 'tienda#search', as: :search
  get 'item-in-stock/:id', to: 'tienda#producto', as: :item
  get 'tienda/carrito'
  get 'tienda/confirmacion_pago', as: :confirmacion_pago
  get 'tienda/lista_de_productos', as: :lista_de_productos
  get 'tienda/actualizar_carrito', as: :actualizar_carrito
  get 'tienda/eliminar_items_del_carrito', as: :eliminar_items_del_carrito
  get 'tienda/crear_pedido', as: :crear_pedido
  post 'tienda/crear_pedido'

  devise_for :users

  resources :products, path: 'admin/products'
  
  get 'admin/products/:id/products_photos',to: 'products#products_photos', as: :gallery
  get 'admin/products/:id/add_photos',to: 'products#add_photos', as: :add_photos
  post 'admin/products/:id/add_photos',to: 'products#add_photos'
  get 'admin/products_import_list', to: 'products#import_list', as: :import_list
  get 'admin/categoria-de-producto', to: 'products#categoria', as: :categoria
  get 'admin/nueva_etiqueta',  to: 'tags_and_categories#nueva_etiqueta', as: :nueva_etiqueta 


  get 'payments/payment_proccess', as: :payment_proccess
  post 'payments/payment_proccess'

  get 'payments/tarjeta', as: :tarjeta
  post 'payments/tarjeta'

  get 'payments/oxxo', as: :oxxo
  post 'payments/oxxo'

end
