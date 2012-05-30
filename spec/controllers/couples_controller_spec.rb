require 'spec_helper'

describe CouplesController do
  def valid_session
    {}
  end

  describe "POST create" do
    let(:pretender_1) { FactoryGirl.create(:pretender) }
    let(:pretender_2) { FactoryGirl.create(:pretender) }
    describe "with valid params" do
      it "creates a new Couple" do
        expect {
          post :create, {couple: {:pretender_a_id => pretender_1.id, :pretender_b_id => pretender_2.id}}, valid_session
        }.to change(Couple, :count).by(1)
      end

      it "redirects to the dashboard" do
        post :create, {couple: {:pretender_a_id => pretender_1.id, :pretender_b_id => pretender_2.id}}, valid_session
        response.should redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "shows a flash alert" do
        # Trigger the behavior that occurs when invalid params are submitted
        Couple.any_instance.stub(:save).and_return(false)
        post :create, {:couple => {}}, valid_session
        flash.alert.should be_present
      end
      it "redirects to the dashboard" do
        Couple.any_instance.stub(:save).and_return(false)
        post :create, {couple: {}}, valid_session
        response.should redirect_to(root_path)
      end
    end
  end

  describe "DELETE destroy" do
  
    let(:couple) { FactoryGirl.create(:couple) }

    it "destroys the couple" do
      expect{
        delete :destroy, id: couple.id
      }.to change{ Couple.where(id: couple.id).first }.from(couple).to(nil)
    end

    it "redirects to the dashboard" do
      delete :destroy, id: couple.id
      response.should redirect_to(root_path)
    end
  
    context "when delete a couple of the previous round" do
      let(:couple) { FactoryGirl.create(:couple, iterations_ago: 1) }

      it "doesn't destroys the couple" do
        expect{
          delete :destroy, id: couple.id
        }.to_not change{ Couple.where(id: couple.id).first }
      end  
    end
  end

  describe "POST round" do
    it "redirects to the dashboard" do
      post :round, {}, valid_session
      response.should redirect_to(root_path)
    end

    it "increments all couples iterations_ago" do
      couple = FactoryGirl.create(:couple)
      expect{
        post :round, {}, valid_session
      }.to change{couple.reload.iterations_ago}.by(1)
    end

    it "sets everyone free" do
      FactoryGirl.create(:pretender, reserved: true)
      Pretender.stub(:any_single?).and_return(false)
      post :round, {}
      Pretender.where(reserved: true).count.should == 0
    end

    context "some pretenders doesn't have couple" do
      before { Pretender.stub(:any_single?).and_return(true) }
      it "doesn't increment any iteration" do
        couple = FactoryGirl.create(:couple)
        expect{
          post :round, {}, valid_session
        }.to_not change{couple.reload.iterations_ago}
      end
    end
  end
end
