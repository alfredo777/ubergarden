class Tag < ApplicationRecord
	has_many :tag_id_and_product_id
    has_many :products , through: :tag_id_and_product_id
end
