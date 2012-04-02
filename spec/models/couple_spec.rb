require 'spec_helper'

describe Couple do

  it 'support couples of one member, for soloing' do
    couple = FactoryGirl.create(:couple, pretender_b: nil)
    couple.should be_valid
  end

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

  describe "for_pretender scope" do
    subject { Couple.for_pretender(pretender) }
    let(:pretender) { FactoryGirl.create(:pretender) }

    context 'as pretender a' do
      let!(:couple) { FactoryGirl.create(:couple, pretender_a: pretender) }
      it { should include(couple) }
    end
    context 'as pretender b' do
      let!(:couple) { FactoryGirl.create(:couple, pretender_b: pretender) }
      it { should include(couple) }
    end

    context 'both are not the expected pretender' do
      let!(:couple) { FactoryGirl.create(:couple) }
      it { should_not include(couple) }
    end
  end

  describe "#all_iterations_ago" do

    let(:pretender_1) { FactoryGirl.create(:pretender) }
    let(:pretender_2) { FactoryGirl.create(:pretender) }

    it 'contains the position for both pretenders' do
      couple = FactoryGirl.create(:couple, pretender_a: pretender_1, pretender_b: pretender_2)
      Couple.all_iterations_ago[pretender_1.id].should == {pretender_2.id => couple.iterations_ago}
    end

    it 'returns the recent iterations ago' do
      FactoryGirl.create(:couple, pretender_a: pretender_1, pretender_b: pretender_2, iterations_ago: 4)
      FactoryGirl.create(:couple, pretender_a: pretender_1, pretender_b: pretender_2, iterations_ago: 1)
      FactoryGirl.create(:couple, pretender_a: pretender_1, pretender_b: pretender_2, iterations_ago: 3)

      Couple.all_iterations_ago[pretender_1.id].should == {pretender_2.id => 1}
      Couple.all_iterations_ago[pretender_2.id].should == {pretender_1.id => 1}
    end

    it 'gets the min value for the permutation' do
      FactoryGirl.create(:couple, pretender_a: pretender_1, pretender_b: pretender_2, iterations_ago: 1)
      FactoryGirl.create(:couple, pretender_a: pretender_2, pretender_b: pretender_1, iterations_ago: 4)

      Couple.all_iterations_ago[pretender_1.id].should == {pretender_2.id => 1}
      Couple.all_iterations_ago[pretender_2.id].should == {pretender_1.id => 1}
    end
  end
end
