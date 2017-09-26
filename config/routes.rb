Rails.application.routes.draw do
  root 'tienda#index'
  get '/terminos_y_condiciones', to: 'tienda#terminos_y_condiciones', as: :terminos
  get '/aviso_de_privacidad', to: 'tienda#aviso_de_privacidad', as: :aviso_de_privacidad
  get 'tienda/fancy', as: :fancy
  get 'tienda/generate_subscriber', as: :generate_subscriber
  post 'tienda/generate_subscriber'
  devise_for :users
  resources :products, path: 'admin/products'
  get 'admin/customers', to: 'customers#index',as: :customers
  get 'admin/orders', to: 'customers#orders', as: :orders
  get 'admin/order/:id', to: 'customers#order', as: :order
  get 'admin/customers/acount', to: 'customers#acount_information', as: :acount
  get 'admin/shipments', to: 'customers#shipments',as: :shipments
  get 'admin/shipment', to: 'customers#shipment', as: :shipment
  get 'admin/find_orders', to: 'customers#find_orders', as: :find_orders
  post 'admin/find_orders', to: 'customers#find_orders'
  get 'admin/import_products', to: 'products#import_products', as: :import_products
  post 'admin/import_products', to: 'products#import_products'
  get 'admin/today_orders', to: 'customers#today_orders', as: :today_orders
  get 'admin/montly_orders', to: 'customers#montly_orders', as: :montly_orders
  get 'admin/inprocess_orders', to: 'customers#inprocess_orders', as: :inprocess_orders
  get 'admin/finish_orders', to: 'customers#finish_orders', as: :finish_orders
  get 'admin/in_send_orders', to: 'customers#in_send_orders', as: :in_send_orders
  get 'admin/activate_order', to: 'customers#activate_order', as: :activate_order
  post 'admin/activate_order', to: 'customers#activate_order'
  get 'admin/send_order', to: 'customers#send_order', as: :send_order
  post 'admin/send_order', to: 'customers#send_order'
  get 'admin/finish_order', to: 'customers#finish_order', as: :finish_order
  post 'admin/finish_order', to: 'customers#finish_order'
  get 'admin/admins',to: 'admins#index', as: :admins
  get 'admin/admins/new',   to: 'admins#new', as: :new_admin
  get 'admin/admins/create',   to: 'admins#create', as: :create
  post 'admin/admins/create',   to: 'admins#create'
  get 'admin/admins/edit',  to: 'admins#edit', as: :edit_admin
  get 'admin/admins/destroy',  to: 'admins#destroy', as: :destroy_admin
  get 'admin/admins/update_admin', to: 'admins#update_admin', as: :update_admin
  post 'admin/admins/update_admin', to: 'admins#update_admin'
  get 'admin/login', to: "admins#login_admin", as: :login
  get 'admin', to: "admins#admin", as: :admin_i
  get 'admin/admins/verify_pass', to: "admins#verify_pass", as: :verify_pass
  post 'admin/admins/verify_pass', to: "admins#verify_pass"
  get 'admin/admins/log_out', to: "admins#log_out", as: :log_out
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
  get 'tienda/buscar_pedido', as: :buscar_pedido
  post 'tienda/buscar_pedido'
  get 'tienda/ver_pedido', as: :ver_pedido
  post 'tienda/ver_pedido'
  get 'tienda/producto_no_encontrado', as: :producto_no_encontrado
  post 'tienda/producto_no_encontrado'
  get 'tienda/contacto', as: :contacto
  post 'tienda/contacto'
  get 'tienda/contactado', as: :contactado
  post 'tienda/contactado'
  get 'tienda/offers', as: :offers
  get 'nosotros', to: 'tienda#nosotros', as: :about_us
  get 'admin/products/:id/products_photos',to: 'products#products_photos', as: :gallery
  get 'admin/products/:id/add_photos',to: 'products#add_photos', as: :add_photos
  post 'admin/products/:id/add_photos',to: 'products#add_photos'
  get 'admin/productos_no_publicados',to: 'products#productos_no_publicados', as: :productos_no_publicados
  post 'admin/productos_no_publicados',to: 'products#productos_no_publicados'
  get 'admin/destroy_photos/:id',to: 'products#destroy_photos', as: :destroy_photos
  post 'admin/destroy_photos/:id',to: 'products#destroy_photos'
  get 'admin/products/:id/activate_inactive',to: 'products#activate_inactive', as: :active_inactive
  post 'admin/products/:id/activate_inactive',to: 'products#activate_inactive'
  get 'admin/active_all',to: 'products#active_all', as: :active_all
  post 'admin/active_all',to: 'products#active_all'
  get 'admin/unactive_all',to: 'products#unactive_all', as: :unactive_all
  post 'admin/unactive_all',to: 'products#unactive_all'
  get 'admin/products_import_list', to: 'products#import_list', as: :import_list
  get 'admin/categoria-de-producto', to: 'products#categoria', as: :categoria
  get 'admin/nueva_etiqueta',  to: 'tags_and_categories#nueva_etiqueta', as: :nueva_etiqueta 
  get 'payments/payment_proccess', as: :payment_proccess
  post 'payments/payment_proccess'
  get 'payments/tarjeta', as: :tarjeta
  post 'payments/tarjeta'
  get 'payments/oxxo', as: :oxxo
  post 'payments/oxxo'

  ######## api routes ########
  get 'api/list_products', :defaults => { :format => 'json' }
  get 'api/best_produtcs', :defaults => { :format => 'json' }
  get 'api/my_products', :defaults => { :format => 'json' }
  get 'api/categorias', :defaults => { :format => 'json' }
  post 'api/my_products', :defaults => { :format => 'json' }
  post 'api/image_products', :defaults => { :format => 'json' }
  get 'api/search', :defaults => { :format => 'json' }


end
