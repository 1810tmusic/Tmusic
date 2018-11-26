class ProductsController < ApplicationController
		# 管理者のみページが開けるようにする
		before_action :admin_user, only: [:new, :edit]

	def top
		@products = Product.includes(:prices).all
	end


	def new
		@product_new = Product.new

		disc = @product_new.discs.build
		disc.songs.build

		@artist_new = Artist.new
		@label_new = Label.new
		@genre_new = Genre.new

		@price = @product_new.prices.build

	end

	def index
		@products = Product.includes(:prices).page(params[:page]).per(24).search(params[:search])
	end

	def show
		@product = Product.find(params[:id])
		@price = Price.find_by(product_id: @product)
	end

	def edit
		@product = Product.find(params[:id])
		@price = Price.find_by(product_id: @product)
		@price_new = Price.new
	end

	def create

		# artist = Artist.create(artist_name: params[:product][:artist])
		# label = Label.create(label_name: params[:product][:label])
		# genre = Genre.create(genre_name: params[:product][:genre])

		product = Product.new(product_params)

		product.artist_id = params[:product][:artist_id]
		product.label_id = params[:product][:label_id]
		product.genre_id = params[:product][:genre_id]

		product.save
		redirect_to products_path

		flash[:notice] = "登録しました"
	end

	def update

		@product = Product.find(params[:id])
		@price = Price.find_by(product_id: @product)
		@product.update(product_params)

		flash[:notice] = "successfully"
		redirect_to products_path
	end


	def destroy
		@product = Product.find(params[:id])
		carts = Cart.joins(:cart_items).where(cart_items:{product_id: @product.id})
		@histories = nil
		carts.each do |cart|
			@histories = History.where(cart_id: cart.id)
		end
		if @histories
			flash[:notice] = "商品 “" + @product.product_name + "” は購入履歴があるため削除できません"
			redirect_to products_path
		else
			@product.discs.each do |disc|
				disc.songs.destroy_all
			end
		  @product.discs.destroy_all
		  @product.prices.destroy_all
			@product.posts.destroy_all
			@product.destroy
		  flash[:notice] = "商品 “" + @product.product_name + "” を削除しました"
			redirect_to products_path
		end
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

	def admin_user
		if current_user.admin != true
			redirect_to "/"
		end
	end

	private
		def product_params
        	params.require(:product).permit(:product_name,:product_image,:stock,:artist_id,:label_id,:genre_id,
        		discs_attributes: [:id, :disc_no, :product_id, :_destroy, songs_attributes: [:id,:song_no,:song,:disc_id, :_destroy]])
		end

end
