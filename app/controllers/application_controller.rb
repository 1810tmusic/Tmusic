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

	def after_sign_in_path_for(resource)
		user_path(@user)
	end


	# deviseのデータ操作を許可するもの
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

    def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :postal_code, :address, :phone_number, :nickname, :birthday])
			devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
		end

end
