class CategoryProduct < ApplicationRecord
	has_many :category_products_and_products
    has_many :products, through: :category_products_and_products
end
