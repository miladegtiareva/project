class AnswersController < ApplicationController
  before_action :set_question!
  before_action :set_answer!, except: :create
  before_action :authenticate_user, only: [:create, :update, :destroy]
  before_action :authorize_answer_owner!, only: [:edit, :update, :destroy]
  def authorize_answer_owner!
    unless user_signed_in? && current_user == @answer.user
      flash[:warning] = "Вы не авторизованы для выполнения этого действия!"
      redirect_to root_path
    end
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def authenticate_user
    unless current_user
      flash[:warning] = 'У вас нет разрешения на выполнение этого действия, так как вы не вошли в систему'
      redirect_to root_path
    end
  end
    def update
      if @answer.update answer_update_params
        flash[:success] = "Ответ обновлен!"
        redirect_to question_path(@question)
      else
        render :edit
      end
    end
  
    def edit
    end
  
    def create
      @answer = @question.answers.build(answer_params.merge(user_id: current_user.id))
      №@answer.user = current_user
      authorize @answer
      if @answer.save
        flash[:success] = "Ответ создан!"
        redirect_to question_path(@question)
      else
        @answers = @question.answers.order created_at: :desc
        render 'questions/show'
      end
    end
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def user_not_authorized
      flash[:warning] = 'У вас нет разрешения на выполнение этого действия, так как вы не вошли в систему'
      redirect_to(request.referer || root_path)
    end

    def destroy
      @answer.destroy
      flash[:success] = "Ответ удален!"
      redirect_to question_path(@question)
    end
  
    private
  
    def answer_params
      if current_user
        params.require(:answer).permit(:content).merge(user_id: current_user.id)
      end
    end

    def answer_update_params
      params.require(:answer).permit(:content)
    end
  
    def set_question!
      @question = Question.find(params[:question_id])
      unless @question
        flash[:warning] = 'Вопрос не найден или у вас нет прав доступа к данному вопросу.'
        redirect_to root_path
      end
    end
  
    def set_answer!
      @answer = @question.answers.find params[:id]
    end
end
