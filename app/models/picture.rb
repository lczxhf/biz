#encoding:utf-8
class Picture
  include Mongoid::Document
  include Mongoid::Timestamps::Short      
  # include BizModule

  field :picture
  mount_uploader :picture, PictureUploader

  belongs_to :shop
  belongs_to :category
  belongs_to :variant
  belongs_to :index_banner
  belongs_to :article
  belongs_to :prize
  
  # belongs_to :message  #
  
  # type: :thumb, :app, :content(default), nil
  def url (type = :thumb)    
    self.picture.send(type).url
  end  

end
