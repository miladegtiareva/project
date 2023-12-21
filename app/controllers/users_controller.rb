class UsersController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[edit update]
  before_action :set_user!, only: %i[edit update]


  def set_user!
    @user = User.find params[:id]
  end

  def require_no_authentication
    return unless user_signed_in?

    flash[:warning] = "Вы уже вошли:)"
    redirect_to root_path
  end

  def require_authentication
    return if user_signed_in?

    flash[:warning] = "Вы не зарегистрированы :("
    redirect_to root_path
  end
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
  def edit
  end
  def sign_in(user)
    session[:user_id]=user.id
  end
  
  def update
    if @user.update user_params
      flash[:success] = "Ваш профиль обновлен!"
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end 
    def new
      @user = User.new
    end
    def create
      @user = User.new user_params
      if @user.save
        sign_in @user
        flash[:success] = "Добро пожаловать, #{@user.name}!"
        redirect_to root_path
      else
        render :new
      end
    end
  
  end