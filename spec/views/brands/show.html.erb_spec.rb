require 'spec_helper'

describe "brands/show.html.erb" do
  before(:each) do
    @brand = assign(:brand, stub_model(Brand,
      :name => "Name",
      :website => "Website",
      :nationality => "Nationality"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Website/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nationality/)
  end
end
