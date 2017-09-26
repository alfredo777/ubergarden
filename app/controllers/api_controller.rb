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
	    @products = Product.where(publicado: true).paginate(:page => params[:page], :per_page => 4).order('created_at DESC')



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
	puts coloresx

	products = Product.find(prodx)
	productos_array = []
	totales = []
	products.each do |p|
		img = p.image_products.last
		imgp = oppen_images(img)
		quantity = prodxy[p.id]
        color = coloresx[p.id]
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
		totales.push(total)
	end
	    puts "totales: #{totales}"
        preparado_de_productos = {productos: productos_array, total_compra: totales.inject(0){|sum,x| sum + x }}

		render json: preparado_de_productos.to_json
	end


	def categorias
		categorias = {categorias: $CATEGORIAS }
		puts "#{categorias}"
		render json: categorias.to_json
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
		urlx = imagen.file.standar.url
	    if urlx.nil?
	      url = nil
	      else
	      if Rails.env == 'production'
	      filename ||= "#{imagen.file.standar.url}"
	      else
	      filename ||= "#{Rails.root}/public#{imagen.file.standar.url}"
	      end
	      if File.exist?(filename)
	      puts "El archivo existe"
	      url = Base64.strict_encode64(open(filename).to_a.join)
	      end
	    end
	    url
	end

end
