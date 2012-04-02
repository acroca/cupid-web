require 'spec_helper'

describe Couple do
  describe "for_pretenders scope" do
    subject { Couple.for_pretenders(pretender_1, pretender_2) }
    let(:pretender_1) { FactoryGirl.create(:pretender) }
    let(:pretender_2) { FactoryGirl.create(:pretender) }

    context '1 as a, 2 as b' do
      let!(:couple) { FactoryGirl.create(:couple, pretender_a: pretender_1, pretender_b: pretender_2) }
      it { should include(couple) }
    end
    context '1 as b, 2 as a' do
      let!(:couple) { FactoryGirl.create(:couple, pretender_b: pretender_1, pretender_a: pretender_2) }
      it { should include(couple) }
    end

    context 'one of them is different' do
      let!(:couple) { FactoryGirl.create(:couple, pretender_a: pretender_1) }
      it { should_not include(couple) }
    end

    context 'both are not included' do
      let!(:couple) { FactoryGirl.create(:couple) }
      it { should_not include(couple) }
    end
  end
end
