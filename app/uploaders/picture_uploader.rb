# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    date = model.created_at
    date_str = date.strftime('%Y%m%d') if date
    "uploads/#{model.class.to_s.underscore}/#{date_str}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    # process :resize_to_fill => [240, 240]
    process :resize_to_limit => [160, -1]
  end

  version :content do
    process :resize_to_limit => [1024, -1]
  end

  version :app do
    process :resize_to_limit => [720, -1]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def default_url  #可以定义默认图片，如过用户没有上传图片，则可以使用默认的图片
    "/assets/images/userinfo.png"
  end

  def filename
    if super.present?
      # current_path 是 Carrierwave 上传过程临时创建的一个文件，有时间标记，所以它将是唯一的
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension.downcase}"
    end
  end

end
