class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update, :destroy]

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
		if @post.update(post_params)
		  flash[:notice] = "コメントの変更を保存しました"
			redirect_to user_posts_path
		else
			flash[:notice] = "30文字を超える長いコメントは保存できません"
			redirect_to user_posts_path
		end
	end

	def posted_users
		@product = Product.find(params[:id])
		@users = @product.users.page(params[:page]).per(10)
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
