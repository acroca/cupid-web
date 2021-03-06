require 'spec_helper'

describe Pretender do
  describe ".enabled" do
    let(:enabled) { FactoryGirl.create(:pretender, disabled: false) }
    let(:disabled) { FactoryGirl.create(:pretender, disabled: true) }
    
    subject { Pretender.enabled }
    
    it { should include(enabled) }
    it { should_not include(disabled) }
  end

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

  describe '#has_couple?' do
    subject { pretender.has_couple? }
    let(:pretender) { FactoryGirl.create(:pretender) }

    it { should be_false }

    context "with a couple as pretender a" do
      before { FactoryGirl.create(:couple, pretender_a: pretender) }
      it { should be_true }
    end
    context "with a couple as pretender b" do
      before { FactoryGirl.create(:couple, pretender_b: pretender) }
      it { should be_true }
    end
    context "with a couple from an older iteration" do
      before { FactoryGirl.create(:couple, pretender_a: pretender, iterations_ago: 1) }
      it { should be_false }
    end
  end

  describe ".any_single?" do
    before { Pretender.delete_all }
    let!(:pretender) { FactoryGirl.create(:pretender) }
    subject { Pretender.any_single? }

    it { should be_true }

    context "disabled" do
      before { pretender.update_attributes disabled: true }
      it { should be_false }
    end

    context "with a couple" do
      before { FactoryGirl.create(:couple, pretender_a: pretender) }
      it { should be_false }
    end

    context "soloing" do
      before { FactoryGirl.create(:couple, pretender_a: pretender, pretender_b: nil) }
      it { should be_false }
    end

  end

  describe "default order" do
    it "orders by name" do
      p1 = FactoryGirl.create(:pretender, name: "A")
      p2 = FactoryGirl.create(:pretender, name: "Z")
      p3 = FactoryGirl.create(:pretender, name: "M")
      Pretender.where(id: [p1.id, p2.id, p3.id]).map(&:name).should == ["A", "M", "Z"]
    end
  end
end
