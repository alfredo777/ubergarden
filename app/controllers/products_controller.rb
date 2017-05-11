class ProductsController < ApplicationController
  layout 'admin'
  before_action :set_product, only: [:show, :edit, :update, :destroy, :products_photos, :add_photos]

  # GET /products
  # GET /products.json
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 20)
  end


  def products_photos
  end

  def add_photos 
    params[:file].each do |file|
      puts "++++++++"
      puts "#{file}"
      @image = ImageProduct.new
      @image.product_id = @product.id
      @image.file = file
      @image.save
    end
    redirect_to :back
  end

  def import_list

  end

  def categoria
     @products = Product.where(categoria_principal_interna: params[:categoria]).paginate(:page => params[:page], :per_page => 20)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to gallery_path(@product.id), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:nombre, :precio, :nombre_cientifico, :luz, :riego, :necesidades, :descripccion, :tamano, :region_climatica, :pais_de_procedencia, :familia, :orden, :categoria_principal_interna, :publicado, :color1, :color2, :color3, :color4, :color5, :name_downcase_no_characters)
    end
end
