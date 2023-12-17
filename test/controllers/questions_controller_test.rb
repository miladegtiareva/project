require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question = questions(:question_one)
  end

  test "should get index" do
    get questions_url
    assert_response :success
  end
end
