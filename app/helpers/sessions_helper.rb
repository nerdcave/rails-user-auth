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

	def ensure_signed_in
		unless signed_in?
			session[:previous_url] = request.url
			redirect_to sign_in_path, alert: "Sign in below"
		end
	end

	def ensure_correct_user(user)
		user == current_user
	end

	def redirect_to_previous_or(path, options = {})
		redirect_to(session[:previous_url] || path, options)
		session.delete(:previous_url)
	end
end
