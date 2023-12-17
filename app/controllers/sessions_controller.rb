class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy
    def new
    end
  
    def create
        user = User.find_by email: params[:email]
        if user&.authenticate(params[:password])
          sign_in(user)
          flash[:success] = "Добро пожаловать снова, #{user.name}!"
          redirect_to root_path
        else
          flash.now[:warning] = "Проверьте наличие, а так же корректность почты и пароля!"
          render :new
        end
      end
      def destroy
        sign_out
        flash[:success] = "Увидимся позже!"
        redirect_to root_path
      end
  end
