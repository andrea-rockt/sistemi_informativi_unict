require 'spec_helper'

describe "stores/index.html.erb" do
  before(:each) do
    assign(:stores, [
      stub_model(Store,
        :name => "Name",
        :address => "Address",
        :city => "City",
        :country => "Country",
        :latitude => 1.5,
        :longitude => 1.5,
        :gmaps => false
      ),
      stub_model(Store,
        :name => "Name",
        :address => "Address",
        :city => "City",
        :country => "Country",
        :latitude => 1.5,
        :longitude => 1.5,
        :gmaps => false
      )
    ])
  end

  it "renders a list of stores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end