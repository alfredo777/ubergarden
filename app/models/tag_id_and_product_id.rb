class TagIdAndProductId < ApplicationRecord
	belongs_to :product 
	belongs_to :tags
end
