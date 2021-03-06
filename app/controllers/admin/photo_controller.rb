
class Admin::PhotoController < Admin::ApplicationController
  include Admin::ApplicationHelper
  
  skip_before_action :verify_authenticity_token
  
  def create
    ["product", "shop", "variant"].each do |nm|
      m_class = Object.const_get nm.classify
      p_id = "#{nm}_id".to_s
      @model = m_class.find(params[p_id])  if params[p_id]
    end

    file = params[:file]
    tempfile = file.tempfile

    @photo = Photo.create
    @photo.name = file.original_filename

    param_id = "#{@model.class.name.underscore}_id"
    @photo.write_attribute param_id, params[param_id]

    exname = "png"
    @photo.url = store_dir + "#{@photo.id.to_s}.#{exname}"
    path = "public/#{@photo.url}"
    File.open(path, "wb") { |f| f.write(tempfile.read) }
    srcimg = MiniMagick::Image.open(path)

    raw_w, raw_h  = FastImage.size path

    {720 => "app", 240 => "middle", 120 => "thumb"}.each do |k,v|
      scale_ratio = k.to_f / raw_w   #default width is 720px
      srcimg.resize "#{raw_w*scale_ratio}x#{raw_h*scale_ratio }" if scale_ratio < 1.0
      srcimg.format "png"
      srcimg.write path.gsub(".png", "_#{v}.png")
    end

    respond_to do |format|
      if @photo.save    
        format.html { render json:{url: @photo.url, id:@photo.id.to_s} }    
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
    
  end

  def destroy
    Photo.where(:id => params[:id]).first.destroy
    render json:{result_code: 1}
  end  

  def store_dir
    date = @photo.created_at || Time.now.strftime('%Y%m%d')
    date_str = date.strftime('%Y%m%d')
    dir = "/uploads/#{@model.class.to_s.underscore}/#{date_str}/"
    FileUtils::mkdir_p  "public#{dir}"
    dir
  end

end
