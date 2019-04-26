require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest

  def setup
    @photo = photos(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Photo.count' do
      post photos_path, params: { photo: { picture: "sample",
                                           title: "sample-title"} }
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Photo.count' do
      delete photo_path(@photo)
    end
    assert_redirected_to new_user_session_path
  end
end
