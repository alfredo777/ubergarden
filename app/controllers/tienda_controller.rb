class TiendaController < ApplicationController
  layout 'single'
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 20).order('created_at DESC')

     render layout: "application"
  end

  def productos
  end

  def search
  end

  def producto
    @product = Product.find(params[:id])
  end

  def carrito
  end

  def confirmacion_pago
  end
end
