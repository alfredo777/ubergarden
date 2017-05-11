class CategoryProductsAndProduct < ApplicationRecord
	belongs_to :category_product
	belongs_to :product
end
