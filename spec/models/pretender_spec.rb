require 'spec_helper'

describe Pretender do
  describe '#iterations_ago_with' do
    subject { main_pretender.iterations_ago_with(couple.pretender_b) }

    let!(:main_pretender) { FactoryGirl.create(:pretender) }
    let!(:couple) { FactoryGirl.create(:couple, pretender_a: main_pretender, iterations_ago: 4) }

    it { should == 4 }

    context "with an older couple" do
      before { FactoryGirl.create(:couple, pretender_a: main_pretender, pretender_b: couple.pretender_b, iterations_ago: 9) }
      it { should == 4 }
    end

    context "with a newer couple" do
      before { FactoryGirl.create(:couple, pretender_a: main_pretender, pretender_b: couple.pretender_b, iterations_ago: 1) }
      it { should == 1 }
    end
  end
end
