class UsersController < ApplicationController
   def index
   end
   def show
     @user = User.find params[:id]
   end
   def edit
     @user = User.find params[:id]
   end

  def new
    @user = User.new
  end

  def create
        @user = User.new user_params
        if @user.save
          session[:user_id] = @user.id
          redirect_to root_path, notice: "User added"
        else
          render :new
        end
  end

  def user_params
  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end


end
