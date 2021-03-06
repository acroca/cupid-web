require 'spec_helper'

describe DashboardController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end

    it 'assigns all the pretenders' do
      get 'show'
      assigns(:pretenders).should have(Pretender.count).pretenders
    end

    it 'assigns the current couples' do
      Couple.delete_all
      couple = FactoryGirl.create(:couple)
      FactoryGirl.create(:couple, iterations_ago: 1)
      get 'show'
      assigns(:couples).should == [couple]
    end
  end

end
