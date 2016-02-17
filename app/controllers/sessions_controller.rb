class SessionsController < ApplicationController

	def index
	end

	def create
		user = User.find_by_email(params[:email])
		
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			session[:name] = user.name
			redirect_to '/users/%d' % session[:user_id], :notice => "Logged in!"
		else
			flash[:errors] = 'Invalid email or password'
			redirect_to '/sessions/new'
		end
	end

	# def log_out
	# 	sessionn.clear

	def delete
		# session.clear
		session[:user_id] = nil
		redirect_to '/sessions/new'
	end

end
