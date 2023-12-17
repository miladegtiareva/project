class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:create]
  before_action :authorize_question_owner!, only: [:edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_user
    unless session[:user_id]
      flash[:alert] = 'Только авторизованные пользователи могут оставлять комментарии.'
      redirect_to root_path
    end
  end

  def first
    @questions = Question.all
  end

  def index
    if params[:query].present?
      @questions = Question.search_by_title(params[:query]).paginate(page: params[:page], per_page: 5)
    else
      @questions = Question.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    end
  end
  
  def show
    @answer = @question.answers.build
    @answers = @question.answers.order(created_at: :desc).page(params[:page])
  end

  def new
    @question = Question.new
    authorize @question
  end

  def create
    @question = current_user.questions.build question_params
    authorize @question
    if @question.save
      flash[:success] = "Вопрос сохранен!"
      redirect_to questions_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:success] = "Вопрос обновлен!"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = "Вопрос удален!"
    redirect_to questions_path
  end
  
  private
  
  def authorize_question_owner!
    unless user_signed_in? && current_user == @question.user
      flash[:warning] = "Вы не авторизованы для выполнения этого действия!"
      redirect_to root_path
    end
  end
  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content)
  end
  def authorize_question!
    authorize(@question || Question)
  end
  

  def user_not_authorized
    flash[:warning] = 'У вас нет разрешения на выполнение этого действия, так как вы не вошли в систему'
    redirect_to(request.referer || root_path)
  end
end
