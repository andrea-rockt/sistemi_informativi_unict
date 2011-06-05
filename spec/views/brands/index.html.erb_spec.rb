require 'spec_helper'

describe "brands/index.html.erb" do
  before(:each) do
    assign(:brands, [
      stub_model(Brand,
        :name => "Name",
        :website => "Website",
        :nationality => "Nationality"
      ),
      stub_model(Brand,
        :name => "Name",
        :website => "Website",
        :nationality => "Nationality"
      )
    ])
  end

  it "renders a list of brands" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nationality".to_s, :count => 2
  end
end
