class UsersController < ApplicationController

	def new
		@user = User.new
		@users = User.all
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			redirect_to posts_path
		else
			render :new
		end
	end

end
