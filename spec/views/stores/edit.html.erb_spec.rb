require 'spec_helper'

describe "stores/edit.html.erb" do
  before(:each) do
    @store = assign(:store, stub_model(Store,
      :name => "MyString",
      :address => "MyString",
      :city => "MyString",
      :country => "MyString",
      :latitude => 1.5,
      :longitude => 1.5,
      :gmaps => false
    ))
  end

  it "renders the edit store form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stores_path(@store), :method => "post" do
      assert_select "input#store_name", :name => "store[name]"
      assert_select "input#store_address", :name => "store[address]"
      assert_select "input#store_city", :name => "store[city]"
      assert_select "input#store_country", :name => "store[country]"
      assert_select "input#store_latitude", :name => "store[latitude]"
      assert_select "input#store_longitude", :name => "store[longitude]"
      assert_select "input#store_gmaps", :name => "store[gmaps]"
    end
  end
end
