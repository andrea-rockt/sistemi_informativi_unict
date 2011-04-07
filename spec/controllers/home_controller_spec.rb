require 'spec_helper'

describe HomeController do
	
	describe "GET 'index'" do
		it "should be successful" do
			get 'index'
			response.should be_success
		end
		
		it "Deve esserci il testo 'benvenuti nella nostra home page' " do
			get :index
			response.should have_selector("div",:id=>"background" ,:contain=> "benvenuti")
		end
	end
	
end
