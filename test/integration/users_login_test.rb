require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aoi)
    @user.confirm
  end

  test "login with invalid information" do
    get new_user_session_path
    assert_template 'sessions/new'
    post user_session_path, params: { user: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  #課題：confirmable問題解決後に対応
  #test "login with valid information" do
  #  get new_user_session_path
  #  post user_session_path, params: {
  #    user: { email: @user.email, password: 'password' } }
  #  assert_template 'static_pages/home'
  #  assert_select "a[href=?]", new_user_session_path, count: 0
  #  assert_select "a[href=?]", user_path(@user)
  #  delete destroy_user_session_path
  #  assert_not is_logged_in?
  #  assert_redirected_to root_url
  #  follow_redirect!
  #  assert_select "a[href=?]", new_user_session_path
  #  assert_select "a[href=?]", destroy_user_session_path, count: 0
  #  assert_select "a[href=?]", user_path(@user), count: 0
  #end

  #課題：confirmable問題解決後に対応
  #test "login with remembering" do
  #  log_in_as(@user, remember_me: '1')
  #  assert_not_empty cookies['remember_token']
  #end
  #
  #test "login without remembering" do
  #  # クッキーを保存してログイン
  #  log_in_as(@user, remember_me: '1')
  #  delete logout_path
  #  # クッキーを削除してログイン
  #  log_in_as(@user, remember_me: '0')
  #  assert_empty cookies['remember_token']
  #end
end
