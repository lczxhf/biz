class Appointment
  include  BaseModel

  belongs_to :user
  belongs_to :sales_man
  belongs_to :product

  field :name
  field :mobile
  field :time, type:DateTime
  field :car_no
  field :remark

  field :state, default:0
  field_display :state, { 0 => '提交', 1=>'完成'}
end
