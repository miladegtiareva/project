require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one) # Предполагаем, что у вас есть фикстура users с данными
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

end
