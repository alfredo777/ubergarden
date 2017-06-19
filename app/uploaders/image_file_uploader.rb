
class ImageFileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::RMagick

  version :big do
     process :resize_to_fill => [726, 600]
     process :convert => 'png'
     process :watermark_2
  end

  version :standar do 
     process :resize_to_fill => [242, 200]
     process :convert => 'png'
     process :watermark
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

  def watermark
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/watermark.png").first
      img = img.composite(logo, Magick::NorthWestGravity, 15, 0, Magick::OverCompositeOp)
    end
  end

  def watermark_2
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/watermark2.png").first
      img = img.composite(logo, Magick::NorthWestGravity, 15, 0, Magick::OverCompositeOp)
    end
  end

end
