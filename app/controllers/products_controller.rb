class ProductsController < ApplicationController

	# before_action :authenticate_user!

	def top
	end

	def new
		@product_new = Product.new
		@disc = @product_new.discs.build
		@song = @disc.songs.build
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

		flash[:notice] = "登録しました"
	end

	def update
	end

	private
		def product_params
        	params.require(:product).permit(:product_name,:product_image,:stock,:artist_id,:label_id,:genre_id,
        		discs_attributes: [:id, :disc_no, :product_id, :_destroy, songs_attributes: [:id,:song_no,:song,:disc_id, :_destroy]])
		end

end
