class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:email])
		if user.try(:authenticate, params[:password])
			sign_in(user, params[:remember_me])
			redirect_to_previous_or(posts_path)
		else
			flash.now.alert = "Incorrect email/password, try again."
			render :new
		end
	end

	def destroy
		sign_out_current_user
		redirect_to sign_in_path, notice: "Signed out"
	end
end
