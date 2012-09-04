module SessionsHelper

	def sign_in(user, remember_me = false)
		if remember_me
			cookies.permanent[:auth_token] = user.auth_token
		else
			cookies[:auth_token] = user.auth_token
		end
	end

	def sign_out_current_user
		cookies.delete(:auth_token)
	end

	def current_user
		@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end

	def signed_in?
		!current_user.nil?
	end

end
