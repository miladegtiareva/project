require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  setup do
    @user = User.create(
      email: 't1@example.com',
      name: 'TestUser1',
      password: '!Ppassword123',
      password_confirmation: '!Ppassword123',
      old_password: '!Ppassword123'
    )

    @question = Question.create(
      title: 'Test Question',
      content: 'This is a test question.',
      user: @user
    )
  end

  test 'should be valid with valid attributes' do
    answer = Answer.new(
      content: 'This is a valid answer.',
      user: @user,
      question: @question
    )

    assert_predicate answer, :valid?, -> { answer.errors.full_messages.join(', ') }
  end

  test 'should not be valid without content' do
    answer = Answer.new(
      content: nil,
      user: @user,
      question: @question
    )

    assert_not answer.valid?
    assert_includes answer.errors.full_messages, "Content не может быть пустым"
  end
end