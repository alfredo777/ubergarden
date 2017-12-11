class ApiController < ApplicationController
	skip_before_filter :verify_authenticity_token 
	before_filter :set_access

	def set_access
	  response.headers["Access-Control-Allow-Origin"] = "*"
	end 

	def best_produtcs
		productos = []
		@products = Product.where(publicado: true).order("RANDOM()").limit(10)

		@products.each do |p|
			img = p.image_products.last
			imgp = oppen_images(img)
			productos.push({
				Id: p.id,
				nombre: p.nombre ,
				nombre_cientifico: p.nombre_cientifico ,
				luz: p.luz ,
				riego: p.riego ,
				necesidades: p.necesidades ,
				descripccion: p.descripccion,
				tamano: p.tamano ,
				pais_de_procedencia: p.pais_de_procedencia ,
				region_climatica: p.region_climatica ,
				familia: p.familia ,
				orden: p.orden ,
				categoria_principal_interna: p.categoria_principal_interna ,
				publicado: p.publicado ,
				color1: p.color1 ,
				color2: p.color2 ,
				color3: p.color3 ,
				color4: p.color4 ,
				color5: p.color5 ,
				oferta: p.oferta ,
				wikipedia_link: p.wikipedia_link ,
				descuento: p.descuento ,
				precio_final: p.precio_final,
				precio: p.precio,
				img: imgp

			})
		end

		preparado_de_productos = { productos: productos }

		render json: preparado_de_productos.to_json
	end

	def list_products
		productos = []
	    @products = Product.where(publicado: true).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')



		@products.each do |p|
			img = p.image_products.last
			imgp = oppen_images(img)
			productos.push({
				Id: p.id,
				nombre: p.nombre ,
				nombre_cientifico: p.nombre_cientifico ,
				luz: p.luz ,
				riego: p.riego ,
				necesidades: p.necesidades,
				descripccion: p.descripccion,
				tamano: p.tamano ,
				pais_de_procedencia: p.pais_de_procedencia ,
				region_climatica: p.region_climatica ,
				familia: p.familia ,
				orden: p.orden ,
				categoria_principal_interna: p.categoria_principal_interna ,
				publicado: p.publicado ,
				color1: p.color1 ,
				color2: p.color2 ,
				color3: p.color3 ,
				color4: p.color4 ,
				color5: p.color5 ,
				oferta: p.oferta ,
				wikipedia_link: p.wikipedia_link ,
				descuento: p.descuento ,
				precio_final: p.precio_final,
				precio: p.precio,
				img: imgp

			})
		end

		puts "Páginas >>>>>#{@products.total_pages}"

		preparado_de_productos = { productos: productos, paginas: @products.total_pages, categoria: ''  }

		render json: preparado_de_productos.to_json

	end


	def my_products

	productos = eval(params[:productos])
	productos = productos.to_a

	#productos.each do |producto|
	#	puts producto[:product]
	#end


	productos_grouped = productos.group_by {|x| x[:product]}

	puts productos_grouped
    prodx = []
    prodxy = []

	productos_grouped.each do |producto|
		prodx.push(producto[0])
		prodxy.push(producto[0], producto[1].size)
	end

	prodxy = Hash[*prodxy]

	puts "#{prodx}"
	puts "#{prodxy}"


	coloresx = []

	prodx.each do |px|
		puts '##########################'
		colorx = []
		colores =  productos_grouped[px].group_by {|x| x[:color]}
		colores.each do |color|
			colorx.push({"#{color[0]}": color[1].size})
		end
		coloresx.push({px => colorx})
	end
	puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{coloresx}"

	products = Product.find(prodx)
	productos_array = []
	productos_array_no_images = []
	totales = []
	products.each do |p|
		last_colors = []
		img = p.image_products.last
		imgp = oppen_images(img)
		quantity = prodxy[p.id]

		coloresx.each do |colores|
			puts colores.key?(p.id)
			if colores.key?(p.id)
				last_colors.push(colores[p.id])
			end
		end 
        color = last_colors[0]
        puts "********************************#{color}"
        total = p.precio_final.to_i * quantity
		productos_array.push({
			Id: p.id,
			nombre: p.nombre ,
			nombre_cientifico: p.nombre_cientifico ,
			descuento: p.descuento ,
			precio_final: p.precio_final,
			color1: p.color1 ,
			color2: p.color2 ,
			color3: p.color3 ,
			color4: p.color4 ,
			color5: p.color5 ,
			oferta: p.oferta ,
			precio: p.precio,
			quantity: quantity,
			color: color,
			img: imgp,
			total: total
		})

		productos_array_no_images.push({
			Id: p.id,
			nombre: p.nombre ,
			nombre_cientifico: p.nombre_cientifico ,
			descuento: p.descuento ,
			precio_final: p.precio_final,
			precio: p.precio,
			quantity: quantity,
			color: color,
			total: total
		})
		totales.push(total)
	end

	    puts "totales: #{totales}"
	    totales =  totales.inject(0){|sum,x| sum + x }
	    envio = transport_cost_by_cuanty(totales)

	    total_envio = totales + envio

        preparado_de_productos = {productos: productos_array, total_compra: totales, envio: envio, productos_no_images: productos_array_no_images }

		render json: preparado_de_productos.to_json
	end


	def categorias
		categorias = {categorias: $CATEGORIAS }
		puts "#{categorias}"
		render json: categorias.to_json
	end

	def favoritos

		array_ids = params[:ids]
		puts array_ids
		if !array_ids.blank?
		array_ids = array_ids.map(&:to_i)
		array_ids = array_ids.uniq

		puts "#{array_ids}"
		@products = Product.where(publicado: true).find(array_ids)
		productos = []
		@products.each do |p|
			img = p.image_products.last
			imgp = oppen_images(img)
			productos.push({
				Id: p.id,
				nombre: p.nombre ,
				nombre_cientifico: p.nombre_cientifico ,
				luz: p.luz ,
				riego: p.riego ,
				necesidades: p.necesidades ,
				descripccion: p.descripccion,
				tamano: p.tamano ,
				pais_de_procedencia: p.pais_de_procedencia ,
				region_climatica: p.region_climatica ,
				familia: p.familia ,
				orden: p.orden ,
				categoria_principal_interna: p.categoria_principal_interna ,
				publicado: p.publicado ,
				color1: p.color1 ,
				color2: p.color2 ,
				color3: p.color3 ,
				color4: p.color4 ,
				color5: p.color5 ,
				oferta: p.oferta ,
				wikipedia_link: p.wikipedia_link ,
				descuento: p.descuento ,
				precio_final: p.precio_final,
				precio: p.precio,
				img: imgp

			})
		end
		else
			productos = []
		end

		preparado_de_productos = { productos: productos }

		render json: preparado_de_productos.to_json
	end


	def generate_mobile_order

		pedido = Pedido.new
	    pedido.codigo = SecureRandom.hex(7)+"#{params[:codigo]}"
	    pedido.total = params[:total]
	    pedido.session_token =  SecureRandom.hex(45)
	    pedido.aceptacion_de_terminos = true
	    pedido.metodo_de_envio = "Uber Garden"
	    pedido.costo_de_envio = params[:envio]
	    pedido.nombre_persona_que_ordena = params[:nombre_persona_que_ordena]
		pedido.apellidos_persona_que_ordena = params[:apellidos_persona_que_ordena]
		pedido.email = params[:email]
		pedido.telefono_fijo = params[:telefono_fijo]
		pedido.telefono_celular = params[:telefono_celular]
		pedido.direccion = params[:direccion]
		pedido.calle = params[:calle]
		pedido.colonia = params[:colonia]
		pedido.numero_exterior = params[:numero_exterior]
		pedido.numero_interior = params[:numero_interior]
		pedido.localidad = params[:localidad]
		pedido.estado = params[:estado]
		pedido.cpostal = params[:cpostal].to_i
		pedido.cpostals = "#{params[:cpostal]}"
		pedido.persona_autorizada_a_recoger_1 = params[:persona_autorizada_a_recoger_1]
		pedido.metodo_de_pago = params[:payment_method]
	    pedido.save

	    lista =eval(params[:productos])
	        
	       line_items = []
		   lista.each do |lista|
		   	   my_colors = []
		   	   lista[:color].each do |color|
		   	   	color.each do |key, value|
		   	   		my_colors.push("#{key} = #{value}")
		   	   	end
		   	   end
		       pp = ProductosAPedido.new 
		       pp.product_id = lista[:Id].to_i
		       pp.pedido_id = pedido.id
		       pp.color = my_colors
		       pp.offer = lista[:descuento].to_i
		       pp.quanty = lista[:quantity]
		       pp.price = lista[:precio_final]
		       pp.total_price = lista[:total]
		       pp.session_token = params[:session_token]
		       pp.save


		       line_items.push({
		        name: lista[:nombre],
		        unit_price: (lista[:precio_final] * 100).to_i,
		        quantity: lista[:quantity]
		       })
	       end

	     puts line_items

	     @line_items = LineItem.new
	     @line_items.session_token = params[:session_token]
	     @line_items.line_items = line_items
	     @line_items.save!

	 	case  params[:payment_method]
	 	when 'oxxo'
				line_items = @line_items.line_items
			    expire = Time.now + 5.days
			    amount_shipment = params[:envio].to_i.round() * 100
			    begin
			        order = Conekta::Order.create({
					  :line_items => eval(line_items),
					  :shipping_lines => [{
					      :amount => amount_shipment,
					      :carrier => "Uber Garden"
					  }],
					  :currency => "MXN",
					  :customer_info => {
					      :name => "#{pedido.nombre_persona_que_ordena} #{pedido.apellidos_persona_que_ordena}",
					      :email => "#{pedido.email}",
					      :phone => "#{pedido.telefono_celular}"
					  },
					  :shipping_contact => {
					      :phone => "#{pedido.telefono_celular}",
					      :receiver => "#{pedido.nombre_persona_que_ordena} #{pedido.apellidos_persona_que_ordena}",
					      :address => {
					          :street1 => "#{pedido.direccion}",
					          :city => "#{pedido.localidad}",
					          :state => "#{pedido.estado}",
					          :country => "MX",
					          :postal_code => "#{pedido.cpostals}",
					          :residential => true
					      }
					  }, 
					  :charges => [{
					  	  :status => "pending_payment",
					      :payment_method => {
					          :type => "oxxo_cash",
					          :expires_at => expire.to_i

					      } 
					  }]
					})
					rescue Conekta::ErrorList => error_list
					  for error_detail in error_list.details do
					    puts error_detail.message
					  end
					end
					@order = order

					puts order 

					puts @order.id 
					puts @order.charges.first.payment_method.reference

				  pedido.conekta_order = @order.id
				  pedido.oxxocode = @order.charges.first.payment_method.reference
				  pedido.save

			pedido = {id: pedido.id, type: 'oxxo', codigo: pedido.codigo, oxxocode: pedido.oxxocode, conekta_order: pedido.conekta_order, email: pedido.email}
	    when 'card'
	    	pedido = {id: pedido.id, type: 'card', codigo: pedido.codigo, conekta_token: $PUBLIC_KEY_CONEKTA, email: pedido.email, line_items_id: @line_items.id, total: params[:total], envio: params[:envio], total_con_envio: params[:envio].to_f + params[:total].to_f }
	    end 

	   puts @line_items
       puts pedido
       render json: pedido.to_json
	end

	def tarjeta_pago_mobil
		puts "Entrando al pago con tarjeta mobil"
		@pedido = Pedido.find(params[:pedido])
			if @pedido.conekta_customer.nil?
			@customer = create_customer("#{@pedido.nombre_persona_que_ordena} #{@pedido.apellidos_persona_que_ordena}", "#{@pedido.email}" ,"#{@pedido.telefono_celular}", 'card', "#{params[:conektaTokenId]}" )
			puts @customer.customer_token_conekta
			puts @customer.customer_name

			  tx = @customer.customer_token_conekta
			  tz = @customer.id
			  conekta_customer = Conekta::Customer.find(@customer.customer_token_conekta)
			  payment_sources = conekta_customer.payment_sources
			  card_token_required = payment_sources[0]["id"]
		      else
		    tx = @pedido.conekta_customer
		    tz = @pedido.customer_register_id
		    card_token_required = ''
	    end

	    @card_token_required = card_token_required


	    if @pedido.conekta_order.nil?
		  p_in = LineItem.find(params[:line_items_id])
	      line_items = p_in.line_items
	      shipping_lines = []
		  @order = create_order(line_items, "#{@customer.customer_token_conekta}", shipping_lines, @pedido, @card_token_required, "#{params[:conektaTokenId]}", params[:envio].to_f )
		  ty = @order.id
	      else
	      ty = @pedido.conekta_order
	    end
	    @pedido.conekta_customer = tx
	    @pedido.conekta_order = ty
	    @pedido.customer_register_id = tz
	    @pedido.save
	    pedido = {id: @pedido.id, type: 'card', codigo: @pedido.codigo, conekta_order: @pedido.conekta_order, pedido: @pedido}
		render json: pedido.to_json
	end

	def create_customer(name, email, phone, pay_type, token)
		internal_customer = CustomerRegister.find_by_customer_email(email)
		if internal_customer.nil?
			customer = Conekta::Customer.create({
			  :name => "#{name}",
			  :email => "#{email}",
			  :phone => "#{phone}",
			  :payment_sources => [{
			    :type => "#{pay_type}",
			    :token_id => "#{token}"
			  }]
			})
			puts customer

			internal_customer = CustomerRegister.new
			internal_customer.customer_token_conekta = customer.id
			internal_customer.customer_email         = customer.email
			internal_customer.customer_phone         = customer.phone 
			internal_customer.customer_name          = customer.name
			if current_user
			internal_customer.user_id                = current_user.id
		    end
			internal_customer.save
	    end

	    @customer = internal_customer
	end

	def create_order(line_items, customer_id, shipping_lines, pedido, card_or_token, token_id, envio)
		@pedido = pedido
        shipment_const = envio.round() * 100
        puts shipment_const
		array_to_order = {
		  :currency => "MXN",
		  :customer_info => {
		    :customer_id => "#{customer_id}"
		  },
		  :line_items => eval(line_items),
			  :shipping_lines => [{
			      :amount => shipment_const,
			      :carrier => "Uber Garden"
			}],
		  :shipping_contact => {
		      :phone => "#{@pedido.telefono_celular}",
		      :receiver => "#{@pedido.nombre_persona_que_ordena} #{@pedido.apellidos_persona_que_ordena}",
		      :address => {
		          :street1 => "#{@pedido.direccion}",
		          :city => "#{@pedido.localidad}",
		          :state => "#{@pedido.estado}",
		          :country => "MX",
		          :postal_code => "#{@pedido.cpostal}",
		          :residential => true
		      }
		  },
		  :charges => [{
	      :payment_method => {
	      		:token_id => token_id,
	          :type => "card"
	      } 
      }]
		}
    puts array_to_order
    begin
		order = Conekta::Order.create(array_to_order)
		rescue Conekta::ErrorList => error_list
		  for error_detail in error_list.details do
		    puts error_detail.message
		  end
		end
		order
	end


	def find_order
		pedido = Pedido.find_by_conekta_order(params[:conekta_order])
		pedido = {pedido: pedido}
		render json: pedido.to_json
	end

	def search
	    @products = Product.where(publicado: true)
	    @products = @products.nombre(params[:search]) if params[:search].present?

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.categoria_principal_interna(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.nombre_cientifico(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.color1(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.color2(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.color3(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.color4(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.color5(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.pais_de_procedencia(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.familia(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.orden(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.region_climatica(params[:search]) if params[:search].present?
	    end

	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.luz(params[:search]) if params[:search].present?
	    end
	    
	    if @products.count == 0
	    @products = Product.where(publicado: true)
	    @products = @products.riego(params[:search]) if params[:search].present?
	    end


	    productos = []
		@products.each do |p|
			img = p.image_products.last
			if img
			imgp = oppen_images(img)
		    else
		    imgp = ""
		    end
			productos.push({
				Id: p.id,
				nombre: p.nombre ,
				nombre_cientifico: p.nombre_cientifico ,
				luz: p.luz ,
				riego: p.riego ,
				necesidades: p.necesidades,
				descripccion: p.descripccion,
				tamano: p.tamano ,
				pais_de_procedencia: p.pais_de_procedencia ,
				region_climatica: p.region_climatica ,
				familia: p.familia ,
				orden: p.orden ,
				categoria_principal_interna: p.categoria_principal_interna ,
				publicado: p.publicado ,
				color1: p.color1 ,
				color2: p.color2 ,
				color3: p.color3 ,
				color4: p.color4 ,
				color5: p.color5 ,
				oferta: p.oferta ,
				wikipedia_link: p.wikipedia_link ,
				descuento: p.descuento ,
				precio_final: p.precio_final,
				precio: p.precio,
				img: imgp

			})
		end

		preparado_de_productos = { productos: productos, paginas: '', categoria: params[:search]  }

		render json: preparado_de_productos.to_json

	end



	def image_products
		producto = Product.find(params[:id])
		all_img = []
		producto.image_products.each do |img|
			img = oppen_images(img)
			all_img.push({
				img: img
			})
		end
		imgx = {imagenes: all_img}
		render json: imgx.to_json
	end

	def oppen_images(imagen)
		urlx = imagen.file.big.url
	    if urlx.nil?
	      url = nil
	      else
	      if Rails.env == 'production'
	      filename ||= "#{imagen.file.big.url}"
	      else
	      filename ||= "#{Rails.root}/public#{imagen.file.big.url}"
	      end
	      #if File.exist?(filename)
	      #puts "El archivo existe"
	      url = Base64.strict_encode64(open(filename).to_a.join)
	      #end
	    end
	    url
	end

end
