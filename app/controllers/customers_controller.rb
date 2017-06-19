class CustomersController < ApplicationController
  layout 'admin'
  before_filter :admin_filter

  def index
    @customers = CustomerRegister.paginate(:page => params[:page], :per_page => 20)
  end

  def orders
   # @orders = Conekta::Order.where(:customer_info['customer_id'] => params[:customer])
   # puts @orders
   if params[:search]
    
    else
    if params[:customer] 
    @orders = Pedido.where(conekta_customer: params[:customer])
    else
    @orders = Pedido.paginate(:page => params[:page], :per_page => 20)
    end
   end
  end

  def order
    @order = Pedido.find(params[:id])
  end

  def today_orders
    @orders = Pedido.where("created_at >= ?", Time.zone.now.beginning_of_day)
    respond_to do |format|
      format.html
      format.csv { render text: @orders.to_csv }
    end
  end

  def montly_orders
    require 'csv'

    @orders = Pedido.this_month

    respond_to do |format|
      format.html
      format.csv { render text: @orders.to_csv }
    end
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



  def acount_information
  end

  def shipments
  end

  def shipment
  end
end
