class PrizeComment
  include  BaseModel

  field :content, type:String
  belongs_to :prize_activity
  belongs_to :user
  belongs_to :prize

  has_many :pictures
end
