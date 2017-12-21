# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base

 #指定照片壓縮程式
 #include Cloudinary::CarrierWave
 include CarrierWave::MiniMagick

#儲存方式
  storage :file
  # storage :fog(存到Amazon S3雲端)

#照片存放路徑 (~/projects/lab1/public/uploads/2015/11/xxx.jpg)
def store_dir
  "uploads/#{model.created_at.year}/#{model.created_at.month}"
end

def cache_dir
  '/tmp/photo-cache'
end

#將檔名更改為雜湊值 (避免上傳檔名重複)
def filename
  if original_filename
    @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
    "#{@name}.#{file.extension}"
  end
end

#預設圖片 (當找不到照片時就會用這張，預設路徑在 app/assets/images/default.jpg)
def default_url
  'default.jpg'
end

#產生各種大小縮圖
#version :authors_image do
#  process :resize_to_fill => [800, 380]
#end

version :large do
  process :resize_to_fit => [800, 800]
end
version :medium do
  process :resize_to_fit => [400, 400]
end
version :small do
  process :resize_to_fit => [200, 200]
end
version :thumb do
  process :resize_to_fit => [80, 80]
end

#允許上傳圖片副檔名類型
def extension_white_list
  %w(jpg jpeg gif png)
end

end
