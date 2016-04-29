class Wap::PrizeActivityController < Wap::ApplicationController
  layout 'wap_no_bottom'

  def index
    @title = "一元拍"
    @items = PrizeActivity.all       
  end

  def show
    @item = PrizeActivity.find_by_id params[:id]
    @title = @item.name    
  end

  def count_result
  		@title = "计算结果"
  		@activity = PrizeActivity.find(params[:id])	
  end

  def prev_activity
  		@title = "往期中奖纪录"
  	  prize_id = PrizeActivity.find(params[:id]).prize.id
  	  @activities = PrizeActivity.where(prize_id:prize_id).where(:lucky_no.exists =>true).order(c_at: :desc)
  end

  def participator
  		@title = "本期参与"
  		@activity = PrizeActivity.find(params[:id])
  end

  def mywin_record
  		@title = "中奖纪录"
  		@activities = @current_user.lotteries.includes(:prize_activity).where(is_winner:true).map(&:prize_activity)
  end
end
