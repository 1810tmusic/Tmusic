class ProductsController < ApplicationController

	def top
		@products = Product.includes(:prices).all
	end

	def new
	end

	def index
	end

	def show
	end

	def edit
	end

	def update
	end
	

end
