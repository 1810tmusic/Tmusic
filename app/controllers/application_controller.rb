class ApplicationController < ActionController::Base


	helper_method :current_cart

	def current_cart
		if Destination.find_by(user_id: current_user.id).present?
		else
			Destination.create(user_id: current_user.id,
												 name: current_user.name,
												 name_kana: current_user.name_kana,
												 postal_code: current_user.postal_code,
												 address: current_user.address,
												 phone_number: current_user.phone_number)
		end

		if Cart.find_by(user_id: current_user.id, done: false).present?
			@cart = Cart.find_by(user_id: current_user.id, done: false)
		else
			@cart = Cart.create(user_id: current_user.id, done: false, destination_id: current_user.destinations.first.id )
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
			# devise_parameter_sanitizer.permit(:account_update, keys: [:email])
		end

end
