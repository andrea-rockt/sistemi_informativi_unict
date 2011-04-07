class HomeController < ApplicationController
	def index
		respond_to do |type|
			@title="Homepage"
			type.html # using defaults, which will render weblog/index.rhtml
		end
	end
end
