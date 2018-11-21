class PostsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@posts = @user.posts
	end

	def edit
		@post = Post.find(params[:id])
		@user = User.find(params[:user_id])
	end

	def update
		@post = Post.find(params[:id])
		@post.update(post_params)
		redirect_to user_posts_path
	end

	def posted_users
		@product = Product.find(params[:id])
		@users = @product.users 
	end

	def create
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to user_posts_path
	end
	


	private

	def post_params
	params.require(:post).permit(:comment, :row_order_position)
  end

end
