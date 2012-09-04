class UsersController < ApplicationController

	def new
		@user = User.new
		@users = User.all
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			redirect_to root_url, notice: "Successfully signed up!"
		else
			render :new
		end
	end

end
