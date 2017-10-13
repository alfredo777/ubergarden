task :evaluated_products => :environment do
    productos = []
	@products =  Product.where(publicado: true).order("RANDOM()").limit(10)
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

		$RANDOMPRODUCTS = { productos: productos }

		sh $RANDOMPRODUCTS

end