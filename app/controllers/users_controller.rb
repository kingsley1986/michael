class UsersController < ApplicationController
  
	def show
		@user = User.find(params[:id])
	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)
  	if @user.save
      log_in @user
      redirect_to user_url(@user)
        flash[:success] = "Welcome to sample App"
  	else
  		render :new
  	end
	end

	private
	def user_params
		params.require(:user).permit(:name, :email,
		 :password, :password_confirmation)
	end

end
