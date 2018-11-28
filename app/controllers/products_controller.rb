class ProductsController < ApplicationController
		# 管理者のみページが開けるようにする
		before_action :admin_user, only: [:new, :create, :edit, :update, :destroy, :price_edit, :price_update]

	def top
		@products = Product.includes(:prices).all
		@top_posts = Product.includes(:prices)
												.find(Post.group(:product_id)
												          .order('count(product_id) desc')
												          .limit(6)
												          .pluck(:product_id))
	end

	def new
		@product_new = Product.new
		disc = @product_new.discs.build
		disc.songs.build
	end

	def index
		@products = Product.includes(:prices).page(params[:page]).per(24).search(params[:search])
	end

	def show
		@product = Product.find(params[:id])
	end

	def edit
		@product = Product.find(params[:id])
	end

	def create
		product = Product.new(product_params)
		product.artist_id = params[:product][:artist_id]
		product.label_id = params[:product][:label_id]
		product.genre_id = params[:product][:genre_id]
		if product.save
				flash[:notice] = "続いて価格を登録してください"
				redirect_to price_new_path(product)
		else
				flash[:notice] = "内容に誤りがあります"
				redirect_to new_product_url	
    end
	end

	def update
		@product = Product.find(params[:id])
		if @product.update(product_params)
			flash[:notice] = "商品の編集内容を保存しました"
			redirect_to product_path(@product.id)
    else
      flash[:notice] = "更新できませんでした"
			render :edit
    end
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
				flash[:notice] = "価格の変更を反映しました"
					render :edit
			end
	end

	# before_action 管理者の定義 [new, create, edit, update, destroy, price_edit, price_update]
	def admin_user
		if current_user.admin != true
			redirect_to "/"
		end
	end

	def info
		@artist = Artist.new
		@label = Label.new
		@genre = Genre.new
	end

	def artist_create
		@artist = Artist.create(artist_name: params[:artist][:artist_name].gsub(/[[:blank:]]+/, ''))
		if @artist.save
			redirect_to new_product_path
		elsif @artist.artist_name.empty?
			flash[:notice] = "空白のアーティストは登録できません"
			redirect_to info_url
		else
			flash[:notice] = "アーティスト “" + @artist.artist_name + "” はすでに登録されています"
			redirect_to info_url
		end
	end

	def label_create
		@label = Label.create(label_name: params[:label][:label_name].strip)
		if @label.save
			redirect_to new_product_path
		elsif @label.label_name.empty?
			flash[:notice] = "空白のレーベルは登録できません"
      redirect_to info_url
		else
			flash[:notice] = "レーベル “" + @label.label_name + "” はすでに登録されています"
			redirect_to info_url
		end
	end

	def genre_create
		@genre = Genre.create(genre_name: params[:genre][:genre_name].strip)
		if @genre.save
			redirect_to new_product_path
		elsif @genre.genre_name.empty?
			flash[:notice] = "空白のジャンルは登録できません"
			redirect_to info_url
		else
			flash[:notice] = "ジャンル “" + @genre.genre_name + "” はすでに登録されています"
			redirect_to info_url
		end
	end

	private
		def product_params
        	params.require(:product).permit(:product_name,:product_image,:remove_product_image,:stock,:artist_id,:label_id,:genre_id,
        		discs_attributes: [:id, :disc_no, :product_id, :_destroy, songs_attributes: [:id,:song_no,:song,:disc_id, :_destroy]])
		end
		def price_params
					params.require(:price).permit(:price)
		end
	end
