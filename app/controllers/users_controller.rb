class UsersController < ApplicationController
  
  #before_action :require_user_logged_in

  
  
  #def index
  #  @users = User.order(id: :desc).page(params[:page]).per(25)
  #end

  #def show
    #@user = User.find(params[:id])
  #end

  def new
    @user = User.new
  end

  def create
   #binding.pry
   @user = User.new(user_params)
   #binding.pry

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      #binding.pry
      #redirect_to @user
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      #binding.pry
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 

  
end
