require 'spec_helper'

describe Couple do
  describe "for_pretender scope" do
    subject { Couple.for_pretender(pretender) }
    let(:pretender) { FactoryGirl.create(:pretender) }

    context 'as a pretender_a' do
      let!(:couple) { FactoryGirl.create(:couple, pretender_a: pretender) }
      it { should include(couple) }
    end

    context 'as a pretender_b' do
      let!(:couple) { FactoryGirl.create(:couple, pretender_b: pretender) }
      it { should include(couple) }
    end

    context 'not including the pretender' do
      let!(:couple) { FactoryGirl.create(:couple) }
      it { should_not include(couple) }
    end
  end
end
