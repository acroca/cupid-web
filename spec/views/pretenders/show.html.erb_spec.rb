require 'spec_helper'

describe "pretenders/show" do
  before(:each) do
    @pretender = assign(:pretender, stub_model(Pretender,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
