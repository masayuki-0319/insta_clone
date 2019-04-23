require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "InstaClone"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", @base_title
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "InstaCloneについて | #{@base_title}"
  end

  test "should get tos" do
    get tos_path
    assert_response :success
    assert_select "title", "利用規約 | #{@base_title}"
  end
end
