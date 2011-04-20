class HomeController < ApplicationController
	def index
		@news = News.all.reverse
		respond_to do |type|
			type.html 
		end
	end
end
