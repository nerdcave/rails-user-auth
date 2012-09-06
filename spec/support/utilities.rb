module Utilities
	def sign_in(user)
		visit sign_in_path
		fill_in "E-mail", with: user.email
		fill_in "Password", with: user.password
		click_button "Sign in"
		cookies[:auth_token] = user.auth_token
	end

	def last_email_sent
		ActionMailer::Base.deliveries.last
	end

	def reset_email
		ActionMailer::Base.deliveries = []
	end
end