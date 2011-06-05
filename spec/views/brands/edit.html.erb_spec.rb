require 'spec_helper'

describe "brands/edit.html.erb" do
  before(:each) do
    @brand = assign(:brand, stub_model(Brand,
      :name => "MyString",
      :website => "MyString",
      :nationality => "MyString"
    ))
  end

  it "renders the edit brand form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => brands_path(@brand), :method => "post" do
      assert_select "input#brand_name", :name => "brand[name]"
      assert_select "input#brand_website", :name => "brand[website]"
      assert_select "input#brand_nationality", :name => "brand[nationality]"
    end
  end
end
