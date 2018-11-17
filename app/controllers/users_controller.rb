class UsersController < ApplicationController

	def index
	end

	def show
	end

	def edit
	end

	def update
	end
	
	# 論理削除（ユーザー退会時の処理）
	def soft_destroy
    @user = User.find(params[:id])
    @user.leave_at = Time.now
    @user.posts.destroy_all
    @user.email += "?"
    until @user.save do
      @user.email += "?"
    end
    if @user.save
      sign_out @user
      redirect_to '/'
    end
  end

end
