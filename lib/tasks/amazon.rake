namespace :super do
task :evaluate_images => :environment do
	@products =  Product.all
	@products.each do |product|
		product.image_products.each do |images|
			puts images.file.big.url.split('?')
			puts images.file.standar.url.split('?')
		end
	end
end
end