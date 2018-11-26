class ProductsController < ApplicationController
		# 管理者のみページが開けるようにする


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

		product.save

		price = Price.new(product_id: product.id, price: params["product"]["prices_attributes"]["0"]["price"].to_i)
		price.save
		redirect_to products_path

		flash[:notice] = "登録しました"
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
		product = Prosuct.find(params[:id])
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
			flash[:hoge] = "空はだめ"
			redirect_to info_url
		else
			flash[:hoge] = "すでに登録されています"
			redirect_to info_url
		end
	end
	def label_create
		@label = Label.create(label_name: params[:label][:label_name].strip)
		if @label.save
			redirect_to new_product_path
		elsif @label.label_name.empty?
			flash[:hoge2] = "空はだめ"
      redirect_to info_url
		else
			flash[:hoge2] = "すでに登録されています"
			redirect_to info_url
		end
	end
	def genre_create
		@genre = Genre.create(genre_name: params[:genre][:genre_name].strip)
		if @genre.save
			redirect_to new_product_path
		elsif @genre.genre_name.empty?
			flash[:hoge3] = "空はだめ"
			redirect_to info_url
		else
			flash[:hoge3] = "すでに登録されています"
			redirect_to info_url
		end
	end
		
	private
		def product_params
        	params.require(:product).permit(:product_name,:product_image,:stock,:artist_id,:label_id,:genre_id,
        		discs_attributes: [:id, :disc_no, :product_id, :_destroy, songs_attributes: [:id,:song_no,:song,:disc_id, :_destroy]])
		end

end
