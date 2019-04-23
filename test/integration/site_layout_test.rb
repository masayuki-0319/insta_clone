require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links for home" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", tos_path
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", new_user_registration_path
    get about_path
    assert_select "title", full_title("InstaCloneについて")
  end

  test "layout links for sign_up" do
    get new_user_registration_path
    assert_response :success
  end
end
