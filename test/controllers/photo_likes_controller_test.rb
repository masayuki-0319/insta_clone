require 'test_helper'

class PhotoLikesControllerTest < ActionDispatch::IntegrationTest

  test "create should require user_signed_in?" do
    assert_no_difference "PhotoLike.count" do
      post photo_likes_path
    end
    assert_redirected_to new_user_session_path
  end

  test "destroy should require user_signed_in?" do
    assert_no_difference "PhotoLike.count" do
      delete photo_like_path(photo_likes(:one))
    end
    assert_redirected_to new_user_session_path
  end
end
