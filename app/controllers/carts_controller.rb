class CartsController < ApplicationController
	before_action :setup_cart_items!, only: [:add_item]

	def add_item
		if @cart_item.blank?
			@cart_item = current_cart.cart_items.build(product_id: params[:product_id])
			@cart_item.save
		else
			@cart_item.update(count: @cart_item.count + 1)
			@cart_item.save
		end
		redirect_to cart_path(current_cart.id)
	end

	def show
		# URLのIDと表示するカートのIDを一致させるために必要です
		@cart = Cart.find(params[:id])
		@cart_items = @cart.cart_items
	end

	def update
		@cart_item = current_cart.cart_items.find(params[:id])
		@cart_item.update(count: params[:cart_item][:count].to_i)
		if @cart_item.count == 0
		@cart_item.destroy
		end
		redirect_to current_cart
	end

	def delete_item
		@cart_item = current_cart.cart_items.find(params[:id])
		@cart_item.destroy
		redirect_to current_cart
	end

	def cart_item_params
		params.require(:cart_items).permit(:count)
	end

	private

	def setup_cart_items!
		@cart_item = current_cart.cart_items.find_by(product_id: params[:product_id])
	end
end
