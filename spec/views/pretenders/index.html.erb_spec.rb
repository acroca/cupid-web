require 'spec_helper'

describe "pretenders/index" do
  before(:each) do
    assign(:pretenders, [
      stub_model(Pretender,
        :name => "Name"
      ),
      stub_model(Pretender,
        :name => "Name"
      )
    ])
  end

  it "renders a list of pretenders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
