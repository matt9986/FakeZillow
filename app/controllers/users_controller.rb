class UsersController < ApplicationController
	def create
		@user = User.new(params[:user])
		if @user.save
			log_in(@user)
      respond_to do |format|
        format.html redirect_to root_url
        format.json render json: {email: user.email}
      end
    else
      flash[:errors] = @user.errors.full_messages
      respond_to do |format|
        format.html { render :new }
          format.json { render json: @user.errors.full_messages, status: 422 }
      end
		end
	end
  
  def new
    render :new
  end
end
