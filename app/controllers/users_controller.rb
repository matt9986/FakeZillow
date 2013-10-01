class UsersController < ApplicationController
	def create
		@user = User.new(params[:user])
		if @user.save
			log_in(@user)
      respond_to do |format|
        format.html redirect_to root_url
        format.json render json: {username: user.username}
      end
    else
      flash[:errors] = @user.errors.full_messages
      respond_to do |format|
        format.html render :new
  			render json: @user.errors.full_messages, status: 422
      end
		end
	end
  
  def new
    render :new
  end
end
