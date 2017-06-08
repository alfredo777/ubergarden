class CategoryProduct < ApplicationRecord
	has_many :category_products_and_products
    has_many :products, through: :category_products_and_products
    has_many :tag_id_and_product_id
    has_many :tags , through: :tag_id_and_product_id
end
