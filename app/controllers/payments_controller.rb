class PaymentsController < ApplicationController
layout 'single'
    skip_before_action :verify_authenticity_token
	def payment_proccess
		if verify_recaptcha
		@pedido = Pedido.find(params[:id])
		@pedido.nombre_persona_que_ordena = params[:nombre_persona_que_ordena]
		@pedido.apellidos_persona_que_ordena = params[:apellidos_persona_que_ordena]
		@pedido.email = params[:email]
		@pedido.email2 = params[:email2]
		@pedido.telefono_fijo = params[:telefono_fijo]
		@pedido.telefono_oficina = params[:telefono_oficina]
		@pedido.telefono_celular = params[:telefono_celular]
		@pedido.direccion = params[:direccion]
		@pedido.calle = params[:calle]
		@pedido.colonia = params[:colonia]
		@pedido.numero_exterior = params[:numero_exterior]
		@pedido.numero_interior = params[:numero_interior]
		@pedido.localidad = params[:localidad]
		@pedido.estado = params[:estado]
		@pedido.cpostal = params[:cpostal]
		@pedido.persona_autorizada_a_recoger_1 = params[:persona_autorizada_a_recoger_1]
		@pedido.persona_autorizada_a_recoger_2 = params[:persona_autorizada_a_recoger_2]
		@pedido.persona_autorizada_a_recoger_3 = params[:persona_autorizada_a_recoger_3]
		@pedido.persona_autorizada_a_recoger_4 = params[:persona_autorizada_a_recoger_4]
		@pedido.metodo_de_pago = params[:payment_method]
		@pedido.save
		else
		flash[:notice] = "Usted necesita dar click en 'No soy un robot.' (al final del formulario)"
		redirect_to :back
		end
  end

  def tarjeta
	@pedido = Pedido.find(params[:id])

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
	  p_in = LineItem.find_by_session_token(session[:session_token])
      line_items = p_in.line_items
      shipping_lines = []
	  @order = create_order(line_items, "#{@customer.customer_token_conekta}", shipping_lines, @pedido, @card_token_required, "#{params[:conektaTokenId]}" )
    
	    ty = @order.id
      else
      ty = @pedido.conekta_order
    end
        @shipment_cost = session[:shipment_cost]
	    @pedido.conekta_customer = tx
	    @pedido.conekta_order = ty
	    @pedido.customer_register_id = tz
	    @pedido.save

	    session[:session_token] = SecureRandom.hex(45)
	    session[:product] = nil
		  session[:price] = nil
		  session[:color] = nil
		  session[:pedido_final] = nil
		  session[:line_items] = nil
		  session[:productos_in_line] = nil
		  session[:shipment_cost] = nil
	      session[:qdep] = nil

	  respond_to do |format|
	  	format.js
	  end
	end

	def oxxo
    @pedido = Pedido.find(params[:id])
    p_in = LineItem.find_by_session_token(session[:session_token])
    line_items = p_in.line_items
    expire = Time.now + 5.days
    begin
    order = Conekta::Order.create({
		  :line_items => eval(line_items),
		  :shipping_lines => [{
		      :amount => session[:shipment_cost].round() * 100,
		      :carrier => "Uber Garden"
		  }],
		  :currency => "MXN",
		  :customer_info => {
		      :name => "#{@pedido.nombre_persona_que_ordena} #{@pedido.apellidos_persona_que_ordena}",
		      :email => "#{@pedido.email}",
		      :phone => "#{@pedido.telefono_celular}"
		  },
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

		puts @order.id 
		puts @order.charges.first.payment_method.reference

	  @pedido.conekta_order = @order.id
	  @pedido.oxxocode = @order.charges.first.payment_method.reference
	  @pedido.save
	  @shipment_cost = session[:shipment_cost]

      session[:session_token] = SecureRandom.hex(45)
      session[:product] = nil
	  session[:price] = nil
	  session[:color] = nil
	  session[:pedido_final] = nil
	  session[:line_items] = nil
	  session[:productos_in_line] = nil
	  session[:shipment_cost] = nil
	  session[:qdep] = nil


		respond_to do |format|
	  	format.js
	  end
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

	def create_order(line_items, customer_id, shipping_lines, pedido, card_or_token, token_id)
		@pedido = pedido

		array_to_order = {
		  :currency => "MXN",
		  :customer_info => {
		    :customer_id => "#{customer_id}"
		  },
		  :line_items => eval(line_items),
			  :shipping_lines => [{
			      :amount => session[:shipment_cost].round() * 100,
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
end
