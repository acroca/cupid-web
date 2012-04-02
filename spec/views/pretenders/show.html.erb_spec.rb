require 'spec_helper'

describe "pretenders/show" do
  before(:each) do
    @pretender = assign(:pretender, stub_model(Pretender,
      :name => "Name"
    ))
    @couples = assign(:couples, [stub_model(Couple, 
      pretender_a: @pretender,
      pretender_b: stub_model(Pretender, name: 'Pretender B'),
    )])
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end

  it "renders other pretenders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Pretender B/)
  end
end
