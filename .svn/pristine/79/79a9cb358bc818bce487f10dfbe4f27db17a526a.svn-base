#encoding:utf-8
class UploadPicController < ApplicationController

  def index
    Rails.logger.info("UploadPicController_index_params=>#{params}")

     ids = params[:ids].split ',' unless params[:ids].nil?
     ids = ids.select {|item| item.present? }
     @screenshots = []
     @screenshots = Picture.where(:id.in=>ids) if ids.present?
    respond_to do |format|
      format.html
      format.js{ render :layout => false}
    end
  end


  def create
    file = params[:qqfile].is_a?(ActionDispatch::Http::UploadedFile) ? params[:qqfile] : params[:file]
    @screenshot = Picture.new
    @screenshot.picture = file
    Rails.logger.info("UploadPicController_create_params=>#{params}")
    if @screenshot.save
      render json: { success: true, id:@screenshot.id.to_s,url:@screenshot.picture.thumb.url}
    else
      render json: @screenshot.errors.to_json
    end
  end


  def destroy
    Rails.logger.info("UploadPicController_destroy_params=>#{params}")
    Rails.logger.info("UploadPicController_destroy_upload_pic_path=>#{upload_pic_path}")
    @screenshot = Picture.find(params[:id])
    @screenshot.destroy

    respond_to do |format|
      # format.html { redirect_to "#{upload_pic_path}?ids=#{params[:all_id]}" }

      format.js{
         @screenshots = []
        render :layout => false
      }
    end

  end

  def banner_create
    file = params[:qqfile].is_a?(ActionDispatch::Http::UploadedFile) ? params[:qqfile] : params[:file]
    @screenshot = IndexBanner.new
    @screenshot.picture = file
    Rails.logger.info("UploadPicController_create_params=>#{params}")
    if @screenshot.save
      render json: { success: true, id:@screenshot.id.to_s,url:@screenshot.picture.thumb.url}
    else
      render json: @screenshot.errors.to_json
    end

  end

  def banner_index

    Rails.logger.info("UploadPicController_index_params=>#{params}")

    ids = params[:ids].split ','unless params[:ids].nil?
    @screenshots = []
    @screenshots = IndexBanner.where(:id.in=>ids) if ids.present?
    respond_to do |format|
      format.html{render 'banner_index'} # dealer_to_user.html.erb
      format.js{ render 'index', :layout => false}
    end


  end


end
