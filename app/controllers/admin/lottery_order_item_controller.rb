class Admin::LotteryOrderItemController < Admin::ApplicationController
  def index
    @columns = ['_id','num', 'user', 'is_winner', 'prize_activity', 'prize_time']

    do_index LotteryOrderItem.where(pay_state:1).desc(:c_at).page(@page)
  end

  def show
  end

  def update
  end


end
