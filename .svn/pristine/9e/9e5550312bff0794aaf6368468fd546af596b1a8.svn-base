node(:draw){@draw}
node(:recordsTotal){ LotteryOrderItem.where(pay_state:1).count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data", :object_root => false  do  
  attributes '_id','num'
  node(:is_winner) {|item| item.is_winner?}  
  node(:user) {|item| item.lottery_order.user.mob}  
  node(:prize_activity) {|item| item.prize_activity.name}  
  node(:prize_time) {|item| item.prize_activity.begin_time.strftime("%Y%m%d%H")}
end

node(:data ){[]} if @items.count == 0

