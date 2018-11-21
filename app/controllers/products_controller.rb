class ProductsController < ApplicationController
		# 管理者のみページが開けるようにする
		before_action :admin_user, only: [:new, :edit]

	def top
		@products = Product.includes(:prices).all
	end


	def new
		@product_new = Product.new
		@disc = @product_new.discs.build
		@song = @disc.songs.build

		@price = @product_new.prices.build
	end

	def index
		@products = Product.all.search(params[:search])
	end

	def show
		@product = Product.find(params[:id])
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
