class PasswordResetsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:email])
		user.try(:send_password_reset)
		redirect_to root_url, notice: "Email sent with instructions"
	end

	def edit
		@user = User.find_by_password_reset_token!(params[:id])
	end

	def update
		@user = User.find_by_password_reset_token!(params[:id])
		if @user.password_reset_expired?
			redirect_to reset_password_path, alert: "Password reset expired"
		elsif @user.update_attributes(params[:user])
			redirect_to root_url, :notice => "Successfully reset password"
		else
			render :edit
		end

	end

end
