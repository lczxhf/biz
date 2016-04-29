class LotteryCartItem
  include  BaseModel

  belongs_to :user
  field :num, type: Integer
  
  belongs_to :prize_activity

  def self.get_cart_by_user user
    items = LotteryCartItem.where(user:user)

    items.map{ |c| {
      id: c.id,
      prize_activity_id: c.prize_activity_id,
      name: c.prize_activity.prize.name,
      price: c.prize_activity.prize.price,
      sale_unit: c.prize_activity.prize.sale_unit,
      total:c.prize_activity.total_share,
      remain: c.prize_activity.total_share - c.prize_activity.saled_share,
      num: c.num,
      picture: c.prize_activity.prize.pictures.first.url(:thumb),
      is_done: c.prize_activity.is_done?
      }
    }
  end 

end
