task :evaluate_images => :environment do
	@products =  Product.all
	@products.each do |product|
		product.image_products.each do |images|
			puts images.file.big.split('?')
			puts images.file.standar.split('?')
		end
	end
end