require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(user_name: "Example User",
                      pen_name: "example user",
                      email: "user@example.com",
                      password: "foobar",
                      password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "user_name should be valid" do
    @user.user_name = ""
    assert_not @user.valid?
    @user.user_name = "a" * 2
    assert_not @user.valid?
    @user.user_name = "a" * 51
    assert_not @user.valid?
  end

  test "pen_name should be valid" do
    @user.pen_name = ""
    assert_not @user.valid?
  end

  test "email should be valid" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses shold be saved as lower-case" do
    mixed_case_email = "Foo@FoFo.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
