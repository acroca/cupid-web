require 'spec_helper'

describe "pretenders/edit" do
  before(:each) do
    @pretender = assign(:pretender, stub_model(Pretender,
      :name => "MyString"
    ))
  end

  it "renders the edit pretender form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pretenders_path(@pretender), :method => "post" do
      assert_select "input#pretender_name", :name => "pretender[name]"
    end
  end
end
