class ProductsController < ApplicationController
  layout 'admin'
  before_action :set_product, only: [:show, :edit, :update, :destroy, :products_photos, :add_photos]
  before_filter :admin_filter

  # GET /products
  # GET /products.json
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 50)
  end

  def productos_no_publicados
    @products = Product.where(publicado: false).paginate(:page => params[:page], :per_page => 50)
  end

  def eliminar_todos_los_productos_sin_publicar
    @products = Product.where(publicado: false)
    @products.each do |p|
      p.destroy
    end
    redirect_to :back
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

  def destroy_photos
    @image = ImageProduct.find(params[:id])
    @image.destroy
    redirect_to :back
  end
  
  def import_list
  end

  def import_products
    require 'csv' 
    file = params[:file]
    uploaded_io = file
    File.open(Rails.root.join('tmp', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end


    csv_text = File.read("#{Rails.root}/tmp/uploads/#{uploaded_io.original_filename}")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Product.create!(row.to_hash)
    end
    redirect_to root_url, notice: 'Productos importados.'
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

  def activate_inactive
   product = Product.find(params[:id])
   if product.publicado
     product.publicado = false
   else
      product.publicado = true
   end
   product.save

   redirect_to :back
  end

  def active_all
    Product.update_all publicado: true
    redirect_to :back
  end

  def unactive_all
    Product.update_all publicado: false
    redirect_to :back
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    puts params[:product][:file]
    if @product.save
        params[:product][:file].each do |file|
          puts "++++++++"
          puts "#{file}"
          @image = ImageProduct.new
          @image.product_id = @product.id
          @image.file = file
          @image.save
        end
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_path(@product.id), notice: 'Product was successfully created.' }
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
      params.require(:product).permit(:nombre, :precio, :nombre_cientifico, :luz, :riego, :necesidades, :descripccion, :tamano, :region_climatica, :pais_de_procedencia, :familia, :orden, :categoria_principal_interna, :publicado, :color1, :color2, :color3, :color4, :color5, :name_downcase_no_characters, :file, :oferta)
    end
end
