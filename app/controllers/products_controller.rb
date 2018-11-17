class ProductsController < ApplicationController

	# before_action :authenticate_user!

	def top
	end

	def new
		@product_new = Product.new
		@disc = @product_new.discs.build
		@song = @disc.songs.build

		@price = @product_new.prices.build
	end


	def index

	end

	def show
	end

	def edit
	end

	def create

		artist = Artist.create(artist_name: params[:product][:artist])
		label = Label.create(label_name: params[:product][:label])
		genre = Genre.create(genre_name: params[:product][:genre])

		product = Product.new(product_params)

		product.artist_id = artist.id
		product.label_id = label.id
		product.genre_id = genre.id

		product.save

		price = Price.new(product_id: product.id, price: params["product"]["prices"]["price"])
		price.save
		flash[:notice] = "登録しました"
	end

	def update
	end

	private
		def product_params
        	params.require(:product).permit(:product_name,:product_image,:stock,:artist_id,:label_id,:genre_id,
        		prices_attributes: [:id, :price, :product_id, :_destroy],
        		discs_attributes: [:id, :disc_no, :product_id, :_destroy, songs_attributes: [:id,:song_no,:song,:disc_id, :_destroy]])
		end

end
