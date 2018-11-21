class UsersController < ApplicationController
		before_action :authenticate_user!
		# ログインユーザーに対するアクション
		before_action :correct_user, only: [:show, :edit, :update, :destination_index, :destination_create, :destination_edit, :destination_update, :destination_destroy, :soft_destroy]
		# 管理者に対するアクション
		before_action :admin_user, only: [:index, :destroy]


	def index
		@users = User.all
	end

	def show
		@age = (Date.today.strftime("%Y%m%d").to_i - @user[:birthday].strftime("%Y%m%d").to_i) / 10000
		@destinations = @user.destinations
	end

	def edit
	end

	def update
		if @user.update(user_params)
            flash[:notice] = "登録情報を変更しました。"
            redirect_to user_path(@user)
    else
            render :edit
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path
	end

	# 配送先のメソッド
	def destination_index
		@destinations = @user.destinations
		@destination = Destination.new
	end

	def destination_create
		@destination = Destination.new(destination_params)
		@destination.user_id = @user.id
		if @destination.save
			flash[:notice] = "配送先を追加しました。"
            redirect_to destination_index_path
		else
			@destinations = @user.destinations
            render :destination_index
		end
	end

	def destination_edit
		@destination = Destination.find(params[:id])
	end

	def destination_update
		@destination = Destination.find(params[:id])
		if @destination.update(destination_params)
			flash[:notice] = "配送先情報を変更しました。"
			redirect_to destination_index_path(@destination.user_id)
		else
			render :destination_edit
		end
	end

	def destination_destroy
		@destination = Destination.find(params[:id])
		@destination.destroy
		redirect_to destination_index_path(@destination.user_id)
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

	def correct_user
		@user = User.find(params[:id])
		if current_user.admin != true
			@user = User.find(current_user.id)
		else
			@user = User.find(params[:id])
		end
	end

	def admin_user
		if current_user.admin != true
			redirect_to "/"
		end
	end

	private
  def user_params
    params.require(:user).permit(:name, :name_kana, :postal_code, :address, :phone_number, :admin, :nickname, :birthday)
	end
	def destination_params
		params.require(:destination).permit(:name, :name_kana, :postal_code, :address, :phone_number, :user_id)
	end
end




