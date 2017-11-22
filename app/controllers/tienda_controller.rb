
class TiendaController < ApplicationController
  before_filter :fancy_filter!, except: [:fancy, :generate_subscriber]
  layout 'single'

  def index
    @products_offer = Product.where("oferta > 0").where(publicado: true).limit(6)
    @products = Product.where(publicado: true).order("RANDOM()").limit(6)
    best_products = ProductosAPedido.limit(100).group(:product_id).order('count_all desc').count
    if best_products.nil?
      @best_products = []
    else
    i = 0
    ids = []
    best_products.each do |key,value|
      if Product.exists?(key)
      ids.push(key)
      end
    end
    end

    @best_products = Product.find(ids)
    render layout: "application"
  end

  
  def terminos_y_condiciones
  end

  def aviso_de_privacidad
  end
  
  def productos
    @products = Product.where(publicado: true).paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    best_products = ProductosAPedido.group(:product_id).order('count_all desc').count
    if best_products.nil?
      @best_products = []
    else
    i = 0
    array_p = []
    best_products.each do |key,value|
      if Product.exists?(key)
      @product = Product.find(key)
      puts @product.nombre
      array_p.push({
       product: @product,
       count: value
      })
      i = i + 1
      if i == 2
         @best_products = array_p
          puts "#{@best_products}"
        return false
      end
      end
    end
    end
  end

  def offers
    @products = Product.where(publicado: true).where('oferta > 0').paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    best_products = ProductosAPedido.group(:product_id).order('count_all desc').count
    if best_products.nil?
      @best_products = []
    else
    i = 0
    array_p = []
    best_products.each do |key,value|
      if Product.exists?(key)
      @product = Product.find(key)
      puts @product.nombre
      array_p.push({
       product: @product,
       count: value
      })
      i = i + 1
      if i == 2
         @best_products = array_p
          puts "#{@best_products}"
        return false
      end
      end
    end
    end
  end

  def nosotros
  end
  def search
    @products = Product.where(publicado: true)
    
    @products = @products.nombre(params[:search]) if params[:search].present?

    if @products.count == 0
    @products = Product.all
    @products = @products.categoria_principal_interna(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.nombre_cientifico(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.color1(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.color2(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.color3(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.color4(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.color5(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.pais_de_procedencia(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.familia(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.orden(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.region_climatica(params[:search]) if params[:search].present?
    end

    if @products.count == 0
    @products = Product.all
    @products = @products.luz(params[:search]) if params[:search].present?
    end
    
    if @products.count == 0
    @products = Product.all
    @products = @products.riego(params[:search]) if params[:search].present?
    end

    best_products = ProductosAPedido.group(:product_id).order('count_all desc').count
    if best_products.nil?
      @best_products = []
    else
    i = 0
    array_p = []
    best_products.each do |key,value|
      if Product.exists?(key)
      @product = Product.find(key)
      puts @product.nombre
      array_p.push({
       product: @product,
       count: value
      })
      i = i + 1
      if i == 2
         @best_products = array_p
          puts "#{@best_products}"
        return false
      end
      end
    end
    end

  end

  def producto
    @product = Product.find(params[:id])

  end

  def carrito
  end

  def actualizar_carrito
    q = params[:cantidad].to_i
    q.times do 
      if session[:product] == nil 
        session[:product] = [params[:product]]
        session[:price] = params[:price]
        color = [] 
        color.push({"#{params[:product]}" =>params[:color]})
        session[:color] = session[:color].to_a + color 
      else
        session[:product] = session[:product] + [ params[:product] ]
        session[:price]   = session[:price].to_f + params[:price].to_f
        color = [] 
        color.push({"#{params[:product]}" =>params[:color]})
        session[:color] = session[:color].to_a + color 
      end
    end



    puts "#{session[:product]}"
    puts "#{session[:price]}"
    puts "#{session[:color]}"
    @q = q
    
    if session[:qdep].nil?
      session[:qdep] = 0
      session[:qdep] = session[:qdep] + @q
      else
      session[:qdep] = session[:qdep] + @q
    end

    session[:shipment_cost] = transport_cost(session[:qdep])

    puts ">>>>>>>>>>>>>>>>>>>>>>>>>> #{session[:qdep]}"
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>> #{session[:shipment_cost]}"
    respond_to do |format|
      format.js
    end
  end

  def eliminar_items_del_carrito
      session[:product] = nil
      session[:price] = nil
      session[:color] = nil
      session[:pedido_final] = nil
      session[:line_items] = nil
      session[:productos_in_line] = nil
      session[:qdep] = nil
      session[:shipment_cost] = nil
       line_items_x = LineItem.find_by_session_token(session[:session_token])
       unless line_items_x.nil?
        line_items_x.destroy
       end

       productos_in_line_x = ProductosInLine.find_by_session_token(session[:session_token])
       unless productos_in_line_x.nil?
        productos_in_line_x.destroy
       end
      flash[:notice] = "Se han eliminado los items del carrito"
      redirect_to :back
  end

  def lista_de_productos
    require 'json'
    @products = session[:product]
    @total = session[:price]
    @colors = session[:color]
    unless @products.nil?
    products = @products.group_by{|x| x}.values
    products_docificate = []

    products.each do |p|
      px = Product.find(p[0].to_i)
      py = p.size

      products_docificate.push([px,py])
    end

    @products = products_docificate
    
    
    @pedido = []
     
     @colors.each do |c|
      c.map { |key, value|  @pedido.push(product_id: key, color: value, oferta: 0) }
     end
     productos_in_line = []
     line_items = []
     @products.each do |product|
       inject = product[0]
       colors = []
       img = inject.image_products.first.file.standar.url
       nombre = inject.nombre 
       id = inject.id
       unit_price = inject.precio_final
       unit_price_x = inject.precio_final * 100
       quantity = product[1].to_i
       order = ""
       total_product = inject.precio_final.round * product[1].to_i

       @colors.each do |color|
          if color["#{inject.id}"]
              colors.push(color["#{inject.id}"])
          end
       end
       my_colors = []
       colors.group_by{|x| x}.values.map.each do |mm|
         my_colors.push( "#{mm[0]} = #{mm.count}" )
       end

       puts "**************************** #{my_colors} colors"

       productos_in_line.push({
        id: id,
        img: img,
        nombre: nombre,
        unit_price: unit_price,
        my_colors:  my_colors,
        quantity: quantity,
        order: order,
        offer: 0,
        total_product: total_product

       })
       
       line_items.push({
        name: nombre,
        unit_price: unit_price_x.to_i,
        quantity: quantity
       })
    end

     session[:pedido_final] = @pedido


     line_items_x = LineItem.find_by_session_token(session[:session_token])
     unless line_items_x.nil?
      line_items_x.destroy
     end

     productos_in_line_x = ProductosInLine.find_by_session_token(session[:session_token])
     unless productos_in_line_x.nil?
      productos_in_line_x.destroy
     end

     line_items_x = LineItem.new
     line_items_x.session_token = session[:session_token]
     line_items_x.line_items = line_items
     line_items_x.save!

     session[:line_items] = line_items_x

     productos_in_line_x  = ProductosInLine.new
     productos_in_line_x.session_token = session[:session_token]
     productos_in_line_x.productos_in_line = productos_in_line
     productos_in_line_x.save!

     session[:productos_in_line] = productos_in_line_x
     puts "#{productos_in_line_x.productos_in_line}"
     @productos = eval(productos_in_line_x.productos_in_line)

     else
     session[:pedido_final] = nil
     session[:line_items] = nil
     session[:productos_in_line] = nil
     @productos = []

   end

  end

  def crear_pedido
    pedido_final = session[:pedido_final]
    productos_in_line_x = session[:productos_in_line]
    lista = eval(productos_in_line_x.productos_in_line)
    pdx = Pedido.find_by_session_token(session[:session_token])
    if pdx.nil?
    pedido = Pedido.new
    pedido.codigo = SecureRandom.hex(10)
    pedido.total = session[:price].to_i
    pedido.session_token =  session[:session_token]
    pedido.aceptacion_de_terminos = params[:conditions]
    pedido.metodo_de_envio = "Uber Garden"
    pedido.costo_de_envio = session[:shipment_cost].round()
     if current_user
      pedido.user_id = current_user.id
     end
    pedido.save
    else
      pedido = pdx 
      pedido.total = session[:price].to_i
      pedido.costo_de_envio = session[:shipment_cost].round()
      pedido.conekta_customer = nil
      pedido.conekta_order = nil
      pedido.customer_register_id = nil
      pedido.save
      destroy_anteriores = pedido.productos_a_pedidos.destroy_all
    end
     lista.each do |lista|
       pp = ProductosAPedido.new 
       pp.product_id = lista[:id].to_i
       pp.pedido_id = pedido.id
       pp.color = lista[:my_colors]
       pp.offer = lista[:offer].to_i
       pp.quanty = lista[:quantity]
       pp.price = lista[:price]
       pp.total_price = lista[:total_product]
       pp.session_token = session[:session_token]
       pp.save
     end

     redirect_to confirmacion_pago_path(id: pedido.id)

  end

  def confirmacion_pago
    @pedido = Pedido.find(params[:id])
  end

  def buscar_pedido
      @order = Pedido.find_by_codigo(params[:search])
      if @order.nil?
        @order = Pedido.find_by_conekta_order(params[:search])
        if @order.nil?
          flash[:notice] = "No se ha encontrado el pedido que se busca"
          redirect_to producto_no_encontrado_path
          else
          redirect_to ver_pedido_path(id: @order.id)
        end

        else
        redirect_to ver_pedido_path(id: @order.id)
      end
  end

  def ver_pedido
    @order = Pedido.find(params[:id])
    best_products = ProductosAPedido.group(:product_id).order('count_all desc').count
    if best_products.nil?
      @best_products = []
    else
    i = 0
    array_p = []
    best_products.each do |key,value|
      @product = Product.find(key)
      puts @product.nombre
      array_p.push({
       product: @product,
       count: value
      })
      i = i + 1
      if i == 2
         @best_products = array_p
          puts "#{@best_products}"
        return false
      end
    end
    end
  end

  def producto_no_encontrado
  end

  def contacto
    redirect_to contactado_path
  end

  def contactado
     best_products = ProductosAPedido.group(:product_id).order('count_all desc').count
    if best_products.nil?
      @best_products = []
    else
    i = 0
    array_p = []
    best_products.each do |key,value|
      @product = Product.find(key)
      puts @product.nombre
      array_p.push({
       product: @product,
       count: value
      })
      i = i + 1
      if i == 2
         @best_products = array_p
          puts "#{@best_products}"
        return false
      end
    end
    end
  end

  def fancy
    render layout: "fancy"
  end

  def generate_subscriber
    @suscriptor = Suscriptor.new
    @suscriptor.name = params[:name]
    @suscriptor.email = params[:email]
    @suscriptor.save
    flash[:notice] = "Gracias por suscribirte a Uber Garden"
    redirect_to fancy_path
  end

  def fancy_filter!
    if $FANCY 
      redirect_to fancy_path
    end
  end
end
