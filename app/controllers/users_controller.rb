class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create_user]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	# before_action :require_login, only: [:secrets, :new_secret, :destroy_secret]
	def show
		@user = User.find(params[:id])
		@secret_all = Secret.where(user:User.find(params[:id]))
		# @likes = Like.where(user:User.find(session[:user_id]))
		# session[:user_id] = @user.id
		# @likes = Likes.all
		@likes = Secret.select('*').joins(:likes).where("likes.user_id = ?",(session[:user_id]))
		# render :text => @likes
	end

	def new
	end
	
	def create_user
		if params[:password_confirmation] == params[:password]
			@new_user = User.create(name:params[:name], email: params[:email], password:params[:password])
			if @new_user.invalid? 
				flash[:error] = @new_user.errors.full_messages
				# flash[:errors] << " can't be blank"

				redirect_to '/users/new'
			else
				@users = User.last
				redirect_to '/users/%d' % @users.id
			end
		else
			flash[:errors] = "passwords don't match"
			redirect_to '/users/new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end
	
	def update
		@user = User.find(session[:user_id])
		@update_user = @user.update_attributes(user_params)
		# render :text => @update_user
		redirect_to '/users/%d' % @user.id
	end

	def destroy
		@user = User.destroy(session[:user_id])
		session.clear
		redirect_to '/sessions/new'
	end

	def secrets
		@secret_all = Secret.all
		# @secret_all = Secret.where(user:User.find(params[:id]))
		# render :text => @secret_all[:secret]
	end

	def new_secret
		@user = User.find(params[:id])
		@secret = Secret.create(secret:params[:secret], user:User.find(params[:id]))
		@secret_all = Secret.where(user:User.find(params[:id]))
		# render :text => @secret.secret
		redirect_to '/users/%d' % @user.id
	end

	def destroy_secret
		@secret = Secret.destroy(params[:id])
		# @secret.destroy_secret if @secret.user == current_user
		redirect_to '/users/%d' % session[:user_id]
	end

	def create_like
		@secret = Like.create(user:User.find(session[:user_id]), secret:Secret.find(params[:id]))
		redirect_to '/secrets'
	end

	def destroy_like
		Like.where("secret_id = ? and user_id = ?",params[:id],session[:user_id])[0].destroy
		redirect_to '/secrets'
	end


	private 
	def user_params
		params.require(:user).permit(:name, :email, :password)
	end



end
