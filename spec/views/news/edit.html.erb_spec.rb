require 'spec_helper'

describe "news/edit.html.erb" do
  before(:each) do
    @news = assign(:news, stub_model(News,
      :title => "MyString",
      :body => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit news form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => news_index_path(@news), :method => "post" do
      assert_select "input#news_title", :name => "news[title]"
      assert_select "textarea#news_body", :name => "news[body]"
      assert_select "input#news_user_id", :name => "news[user_id]"
    end
  end
end
