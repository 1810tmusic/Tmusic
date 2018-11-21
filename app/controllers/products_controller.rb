class ProductsController < ApplicationController

	# before_action :authenticate_user!

	def top
	end

	def new
		@product_new = Product.new
		disc = @product_new.discs.build
		disc.songs.build

		@price = @product_new.prices.build
	end


	def index
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


	private
		def product_params
        	params.require(:product).permit(:product_name,:product_image,:stock,:artist_id,:label_id,:genre_id,
        		discs_attributes: [:id, :disc_no, :product_id, :_destroy, songs_attributes: [:id,:song_no,:song,:disc_id, :_destroy]])
		end

end
