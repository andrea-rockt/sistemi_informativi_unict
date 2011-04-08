class HomeController < ApplicationController
	def index
		@news = News.all
		respond_to do |type|
			type.html # using defaults, which will render weblog/index.rhtml
		end
	end
end
