class ProductsController < ApplicationController
		# 管理者のみページが開けるようにする
		before_action :admin_user, only: [:new, :create, :edit, :update, :destroy, :price_edit, :price_update]

	def top
		@products = Product.includes(:prices).all
	end


	def new
		@product_new = Product.new
		disc = @product_new.discs.build
		disc.songs.build

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

		artist = Artist.create(artist_name: params[:product][:artist])
		label = Label.create(label_name: params[:product][:label])
		genre = Genre.create(genre_name: params[:product][:genre])
		product = Product.new(product_params)

		# product.artist_id = artist.id
		# product.label_id = label.id
		# product.genre_id = genre.id

		if product.save
				price = Price.new(product_id: product.id, price: params["product"]["prices_attributes"]["0"]["price"].to_i)
				price.save
				@price.product_id = @product.id
				redirect_to price_new_path(@product.id)

				flash[:notice] = "続いて価格を登録してください"

		else
				flash[:notice] = "内容に誤りがあります"
				render :new
		end
	end

	def update

		@product = Product.find(params[:id])
		@price = Price.find_by(product_id: @product)

		price = Price.new(price: params["product"]["prices_attributes"]["0"]["price"].to_i)
		if @price != price.price
			price.product_id = @product.id
			price.save!
		end
		@product.update(product_params)

		# @price.update(product_id: @product.id, price: params["product"]["prices_attributes"]["0"]["price"].to_i)
		flash[:notice] = "successfully"
		redirect_to products_path

	end


	def destroy
		product = Product.find(params[:id])
		price = Price.find_by(product_id: @product)
		post.destroy
		price.destroy
		redirect_to products_path
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

	# 価格の登録・編集メソッド
	def price_new
		@product = Product.find(params[:id])
		@price = Price.new
		@price.product_id = @product.id
	end

	def price_create
		@product = Product.find(params[:id])
		@price = Price.new(price_params)
			unless Price.find_by(product_id: @product.id)
					@price.product_id = @product.id
				  @price.save
					flash[:notice] = "商品の新規登録が完了しました"
					redirect_to product_path(@product)
			else
				@price.product_id = @product.id
				@price.save
				flash[:notice] = "価格を追加しました"
					render :edit
			end
	end


	# before_action 管理者の定義 [new, create, edit, update, destroy, price_edit, price_update]
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
		def price_params
					params.require(:price).permit(:price)
		end
	end
