require 'test_helper'
class AnswersControllerTest < ActionController::TestCase
  def setup
    @user = users(:example_user)
    @question = questions(:example_question)
    @answer = answers(:example_answer)
  end

  test 'should redirect create if user is not authorized' do
    post :create, params: { question_id: @question.id, answer: { content: 'New answer content' } }
    assert_redirected_to root_path
    assert_equal 'У вас нет разрешения на выполнение этого действия, так как вы не вошли в систему', flash[:warning]
  end

  test 'should redirect edit if user is not authorized' do
    get :edit, params: { question_id: @question.id, id: @answer.id }
    assert_redirected_to root_path
    assert_equal 'Вы не авторизованы для выполнения этого действия!', flash[:warning]
  end

  test 'should redirect destroy if user is not authorized' do
    delete :destroy, params: { question_id: @question.id, id: @answer.id }
    assert_redirected_to root_path
    assert_equal 'У вас нет разрешения на выполнение этого действия, так как вы не вошли в систему', flash[:warning]
  end

  test 'should not render edit template if user is not authorized' do
    get :edit, params: { question_id: @question.id, id: @answer.id }

    assert_redirected_to root_path
    assert_equal 'Вы не авторизованы для выполнения этого действия!', flash[:warning]
  end
  
  end