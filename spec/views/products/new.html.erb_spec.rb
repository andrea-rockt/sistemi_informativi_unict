require 'spec_helper'

describe "products/new.html.erb" do
  before(:each) do
    assign(:product, stub_model(Product,
      :model => "MyString",
      :price => 1,
      :quantity => 1,
      :size => "MyString",
      :year => 1
    ).as_new_record)
  end

  it "renders new product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => products_path, :method => "post" do
      assert_select "input#product_model", :name => "product[model]"
      assert_select "input#product_price", :name => "product[price]"
      assert_select "input#product_quantity", :name => "product[quantity]"
      assert_select "input#product_size", :name => "product[size]"
      assert_select "input#product_year", :name => "product[year]"
    end
  end
end
