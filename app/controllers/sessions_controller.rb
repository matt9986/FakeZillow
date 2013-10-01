class SessionsController < ApplicationController

	def create
		user = User.find_by_email(params[:user][:email])
		if user && user.password == params[:user][:password]
			log_in(user)
      respond_to do |format|
        format.html redirect_to root_url
        format.json render json: {username: user.username}
      end
		else
      respond_to do |format|
        format.html render :new
        format.json render json: ["There was a problem with your login information"], status: 404
      end
		end
	end

	def destroy
		log_out
    respond_to do |format|
        format.html redirect_to root_url
        format.json render json: "You've logged out"
    end
	end
  
  def new
    render :new
  end

	def show
		if logged_in?
			render json: {username: current_user.username}
		else
			render json: nil, status: 200
		end
	end  
end
