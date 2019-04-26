require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  def setup
    @user = users(:aoi)
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    @photo = @user.photos.new(picture: picture, title: "STitle")
  end

  test "should be valid" do
    assert @photo.valid?
  end

  test "user id should be present" do
    @photo.user_id = nil
    assert_not @photo.valid?
  end

  test "title should be at most 50 characters" do
    @photo.title = "a" * 51
    assert_not @photo.valid?
  end

  test "order should be most reent first" do
    assert_equal photos(:most_recent), Photo.first
  end

  test "associated photos should be destroyed" do
    assert_difference "Photo.count", 1 do
      picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
      @user.photos.create!(picture: picture, title: "Dlete Test")
    end
    assert_difference "Photo.count", -@user.photos.count do
      @user.destroy
    end
  end
end
