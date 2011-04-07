require 'spec_helper'

describe HomeController do
	
	describe "GET 'index'" do
		render_views
		
		it "should be successful" do
			get 'index'
			response.should be_success
		end
		
		it "Deve esserci il testo 'benvenuti nella nostra home pa ge' " do
			get 'index'
			response.body.should have_selector("div",:id=>"background")  do |div|
				div.should contain("benvenuti")
			end
		end
		
		it "should have the right title" do
			get :index
			response.body.should have_selector("title") do |title|
				title.should contain("Homepage")
			end
		end
	end
	
end
