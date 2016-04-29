class Admin::Emplyee
  include  BaseModel
  mount_uploader :avatar, PictureUploader

  field :gender
  field :avatar

  field :name, type:String
  field :mobile, type:String   

end
