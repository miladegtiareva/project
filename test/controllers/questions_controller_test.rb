require 'test_helper'
class QuestionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
    def setup
        @user = users(:example_user)
        @question = questions(:example_question)
        @answer = answers(:example_answer)
      end
  

      test 'should get index' do
        get questions_url
        assert_response :success
      end
      test 'should show question' do
        get question_url(@question)
        assert_response :success
      end
    
      test 'should not create question if user is not authenticated' do
        assert_no_difference('Question.count') do
          post questions_url, params: { question: { title: 'New Question', content: 'Question Content' } }
        end
    
        assert_redirected_to root_url
        assert_equal 'Только авторизованные пользователи могут оставлять комментарии.', flash[:alert]
      end
end