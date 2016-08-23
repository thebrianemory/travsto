class ImageUploader < CarrierWave::Uploader::Base
  storage :aws
  include CarrierWave::MiniMagick

  process resize_to_fit: [800, 600]

  version :thumb do
    process resize_to_fill: [300,200]
  end

  def store_dir
    "public/images/uploads/#{model.id}"
  end

  def cache_dir
    "public/images/uploads/tmp/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end

  private

  def is_landscape? picture
    image = MiniMagick::Image.open(picture.path)
    image[:width] > image[:height]
  end
end
