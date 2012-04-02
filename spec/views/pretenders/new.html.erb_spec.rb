require 'spec_helper'

describe "pretenders/new" do
  before(:each) do
    assign(:pretender, stub_model(Pretender,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new pretender form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pretenders_path, :method => "post" do
      assert_select "input#pretender_name", :name => "pretender[name]"
    end
  end
end
