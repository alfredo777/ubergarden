class Product < ApplicationRecord
	has_many :category_products_and_products
    has_many :category_products, through: :category_products_and_products
    has_many :image_products
end
