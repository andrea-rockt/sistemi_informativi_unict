class HomeController < ApplicationController
	before_filter :require_admin!, :only =>[:admin]
	def index
		@news = News.all.reverse
		respond_to do |type|
			type.html
      type.mobile { render :layout => "mobile"} 
		end
	end
	
	def admin
		respond_to do |type|
			type.html
		end
	end
end
