require 'spec_helper'

describe PretendersHelper do
  describe "partner name" do
    let(:couple) { FactoryGirl.create(:couple) }
    let(:pretender) { couple.pretender_a }
    subject { helper.partner_name(couple, pretender) }

    it { should == couple.pretender_b.name }

    context "as partner b" do
      let(:pretender) { couple.pretender_b }
      it { should == couple.pretender_a.name }
    end

    context "soloing" do
      let(:couple) { FactoryGirl.create(:couple, pretender_b: nil) }
      it { should == "- Solo -" }
    end
  end
end
