require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path,
        params: { user:
          { user_name: "",
            pen_name: "Example User",
            email: "user@example.com",
            password: "password",
            password_confirmation: "password" } }
    end
    assert_template 'devise/registrations/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path,
        params: { user:
          { user_name: "Example User",
            pen_name: "Example User",
            email: "user@example.com",
            password: "password",
            password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash.empty?
  end
end
