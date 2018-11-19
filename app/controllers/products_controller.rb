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

	def post
		product = Product.find(params[:id])
		if product.posted_by?(current_user)
			post = current_user.posts.find_by(product_id: product.id)
			post.destroy
			render json: product.id
		else
			post = current_user.posts.new(product_id: product.id)
			post.save!
			render json: product.id
		end
	end

	private

	  def product_params
	  	params.require(:product).permit(:product_name, :product_image_id, :stock,
	  	 :artist_id, :label_id, :genre_id)
	  end
end
