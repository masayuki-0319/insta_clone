require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  include Warden::Test::Helpers

  def setup
    @user = users(:aoi)
  end

  test "profile display" do
    login_as(@user, scope: :user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.user_name)
    assert_match @user.photos.count.to_s, response.body
    assert_select 'div.pagination'
    @user.photos.paginate(page: 1).each do |photo|
      assert_match photo.title, response.body
    end
  end
end
