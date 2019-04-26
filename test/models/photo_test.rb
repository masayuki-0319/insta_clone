require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  def setup
    @user = users(:aoi)
    @photo = Photo.new(picture: "SPicture", title: "STitle", user_id: @user.id)
  end

  test "should be valid" do
    assert @photo.valid?
  end

  test "user id should be present" do
    @photo.user_id = nil
    assert_not @photo.valid?
  end

  test "picture should be present" do
    @photo.picture = "   "
    assert_not @photo.valid?
  end

  test "title should be at most 50 characters" do
    @photo.title = "a" * 51
    assert_not @photo.valid?
  end
end
