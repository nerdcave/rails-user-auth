class PostsController < ApplicationController
	before_filter :ensure_signed_in

	def index
		@posts = current_user.posts.order("created_at DESC")
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(params[:post])
		if @post.save
			redirect_to posts_path, notice: "Post created successfully"
		else
			render :new
		end
	end

	def destroy
		@post = current_user.posts.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

end
