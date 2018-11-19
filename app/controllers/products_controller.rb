class ProductsController < ApplicationController

	def top
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new

	def index
	end

	def show
	end

	def edit
	end

	def update
	end

	private

	  def product_params
	  	params.require(:product).permit(:product_name, :product_image_id, :stock,
	  	 :artist_id, :label_id, :genre_id)
	  end
end
