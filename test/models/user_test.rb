class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      email: 'test@example.com',
      name: 'TestUser',
      password: '!Ppassword123',
      password_confirmation: '!Ppassword123', 
      old_password: '!Ppassword123'
    )

    @question = @user.questions.build(
      title: 'Test Question',
      content: 'This is a test question.'
    )

    @answer = Answer.new(
      content: 'This is a test answer.',
      user: @user,
      question: @question
    )
  end

  test 'should be valid' do
    assert_predicate @user, :valid?, -> { @user.errors.full_messages.join(', ') }
    assert_predicate @question, :valid?, -> { @question.errors.full_messages.join(', ') }
  end

  test "should not be valid without a name" do
    @user.name = nil
    assert_not @user.valid?
    assert_includes @user.errors.full_messages, "Name не может быть пустым"
  end
  test "should not be valid without an email" do
    @user.email = nil
    assert_not @user.valid?
    assert_includes @user.errors.full_messages, "Email не может быть пустым"
  end

  test "should not be valid with a duplicate email" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors.full_messages, "Email уже существует"
  end
  test "should not be valid with a password less than 8 characters" do
    @user.password = "Pass"
    assert_not @user.valid?
    assert_includes @user.errors.full_messages, "Password confirmation не совпадает со значением поля Password", "Password недостаточной длины (не может быть меньше 8 символов)"
  end
end
