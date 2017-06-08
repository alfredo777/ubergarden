
class ImageFileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  version :big do
     process :resize_to_fill => [726, 600]
  end

  version :standar do 
     process :resize_to_fill => [242, 200]
  end

  if Rails.env == 'development'
    storage :file
   else
    #storage :fog
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
