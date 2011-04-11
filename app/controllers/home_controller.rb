class HomeController < ApplicationController
	def index
		@news = News.all
      	logger.debug @current_user.to_s
		respond_to do |type|
			type.html # using defaults, which will render weblog/index.rhtml
		end
	end
end
