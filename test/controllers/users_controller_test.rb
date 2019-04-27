require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aoi)
    @other_user = users(:hinata)
  end

  test "should get new" do
    get new_user_session_path
    assert_response :success
  end

  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to new_user_session_path
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to new_user_session_path
  end
end
