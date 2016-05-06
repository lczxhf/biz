require 'rails_helper'

RSpec.describe Wap::PrizeActivityController, type: :controller do
  let(:activity) {create(:prize_activity)}
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show,id:activity
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #count_result" do
    it "returns http success" do
      get :count_result,id:activity
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #participator" do
    it "returns http success" do
      get :participator,id:activity
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #prev_activity" do
      it 'returns http success' do
          get :prev_activity,id:activity
          expect(response).to have_http_status(:success)
      end

      it 'have no prev_activity' do
          get :prev_activity,id:activity
          expect(assigns(:activities)).to eq []
      end

      it 'have one prev_activity' do
          create(:prize_activity,prize:activity.prize,lucky_no:123)
          get :prev_activity,id:activity
          expect(assigns(:activities).size).to eq 1
      end
  end

  describe 'GET #mywin_record' do
      let(:user) { create(:user)}
      before { session[:user_id] = user.id }
      it 'have not buy' do
          get :mywin_record
          expect(assigns(:activities)).to eq []
      end
      it 'have already buy any' do
          activity = create(:already_end_activity)
          session[:user_id] = activity.get_lucky_user.id
          get :mywin_record
          expect(assigns(:activities)).to eq [activity]
      end
  end
end
