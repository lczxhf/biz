class Wap::PrizeActivityController < Wap::ApplicationController
  layout 'wap_no_bottom'

  def index
    @title = "一元拍"
    @items = PrizeActivity.where(end_time:nil).desc(:begin_time)       
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

  def award_share
      @title = "奖品晒单"
      prize_id = PrizeActivity.find(params[:id]).prize.id
  end

  def evaluate_page
      @title = '评价'
      prize_activity = PrizeActivity.find(params[:id])
      redirect_to :back unless @current_user == prize_activity.get_lucky_user
  end

  def evaluate
      prize_activity = PrizeActivity.find(params[:id])
      if @current_user == prize_activity.get_lucky_user
          render plian: 'ok'
      else
        redirect_to :back 
      end
      
  end

end
