class ImageProduct < ApplicationRecord
	belongs_to :product

	mount_uploader :file, ImageFileUploader


end
