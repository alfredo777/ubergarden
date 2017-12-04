class CustomersController < ApplicationController
  layout 'admin'
  before_filter :admin_filter

  def index
    @customers = CustomerRegister.paginate(:page => params[:page], :per_page => 20).order('created_at DESC')
  end

  def orders
   # @orders = Conekta::Order.where(:customer_info['customer_id'] => params[:customer])
   # puts @orders
   if params[:search]
    
    else
    if params[:customer] 
    @orders = Pedido.where(conekta_customer: params[:customer]).paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    else
    @orders = Pedido.paginate(:page => params[:page], :per_page => 20).order('created_at DESC')
    end
   end
  end

  def order
    @order = Pedido.find(params[:id])
  end

  def today_orders
    require 'csv'
    @orders = Pedido.where("created_at >= ?", Time.zone.now.beginning_of_day).where("conekta_order <> ''").paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    respond_to do |format|
      format.html
      format.csv { render text: @orders.to_csv }
    end
  end

  def montly_orders
    require 'csv'

    @orders = Pedido.this_month.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')

    respond_to do |format|
      format.html
      format.csv { render text: @orders.to_csv }
    end
  end

  def inprocess_orders
    @orders = Pedido.where(activacion_de_pedido: true).paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
  end

  def finish_orders
    @orders = Pedido.where(finalizacion_de_pedido: true).paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
  end

  def in_send_orders
    @orders = Pedido.where(estatus_del_pedido: "En trayecto").paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
  end

  def find_orders
    @order = Pedido.find_by_codigo(params[:search])

    if @order.nil?
      @order = Pedido.find_by_conekta_order(params[:search])
      if @order.nil?
        flash[:notice] = "No se ha encontrado el pedido que se busca"
        redirect_to :back
        else
        redirect_to order_path(id: @order.id)
      end

      else
      redirect_to order_path(id: @order.id)
    end
  end

  def activate_order
    @order = Pedido.find_by_codigo(params[:code])
    @order.activacion_de_pedido = true
    @order.estatus_del_pedido = "En almacen"
    @order.save
    redirect_to :back
  end

  def finish_order
    @order = Pedido.find_by_codigo(params[:code])
    @order.finalizacion_de_pedido = true
    @order.estatus_del_pedido = "Pedido finalizado"
    @order.save
    redirect_to :back
  end

  def send_order
    @order = Pedido.find_by_codigo(params[:code])
    @order.estatus_del_pedido = "En trayecto"
    @order.save
    redirect_to :back
  end



  def acount_information
    @customer = CustomerRegister.find_by_customer_email(params[:email])
    @orders = @customer.pedidos.last(10)
  end

  def shipments
  end

  def shipment
  end
end
