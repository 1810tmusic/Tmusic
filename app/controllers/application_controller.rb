class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	helper_method :current_cart

	def current_cart
		if Cart.find_by(user_id: current_user.id, done: false).present?
			@cart = Cart.find_by(user_id: current_user.id, done: false)
		else
			@cart = Cart.create(user_id: current_user.id, done: false)
		end
	end
end
