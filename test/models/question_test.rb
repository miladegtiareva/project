require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  setup do
    @user = User.create(
      email: 'test2@example.com',
      name: 'TestUser2',
      password: '!Ppassword123',
      password_confirmation: '!Ppassword123',
      old_password: '!Ppassword123'
    )

    @question = @user.questions.build(
      title: 'Test Question',
      content: 'This is a test question.'
    )
  end

  test 'should not be valid without a title' do
    @question.title = nil
    assert_not @question.valid?
    assert_includes @question.errors.full_messages, "Title не может быть пустым"
  end

  test 'should not be valid without content' do
    @question.content = nil
    assert_not @question.valid?
    assert_includes @question.errors.full_messages, "Content не может быть пустым"
  end

  test 'should belong to a user' do
    @question.user = nil
    assert_not @question.valid?
    assert_includes @question.errors.full_messages, 'User не может отсутствовать'
  end
end
