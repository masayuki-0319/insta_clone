require 'test_helper'

class PhotoLikeTest < ActiveSupport::TestCase

  def setup
    @user1 = users(:kokona)
    @photo1 = photos(:most_recent)
    @photo2 = photos(:orange)
    @like1 = PhotoLike.new(liker_id: @user1.id, photo_id: @photo1.id)
  end

  test "should be valid" do
    assert @like1.valid?
  end

  test "should destroy when user || photo destroyed" do
    #User削除でLikeも削除
    @like1.save
    assert_difference "PhotoLike.count", -1 do
      @user1.destroy
    end
    #Photo削除でLikeも削除
    assert_difference "PhotoLike.count", -1 do
      @photo2.destroy
    end
  end

  test "should like and unlike a photo" do
    liker = users(:kaede)
    photo = photos(:orange)
    #いいね！関係無し
    assert_not photo.liking?(liker)
    assert_not liker.liking?(photo)
    #いいね！関係構築
    liker.like(photo)
    assert photo.liking?(liker)
    assert liker.liking?(photo)
    #いいね！関係解除
    liker.unlike(photo)
    assert_not liker.liking?(photo)
  end

  #  # 外部キーのため，Userモデルで実装済み
  #  test "should require a liker_id" do
  #    @like1.liker_id = nil
  #    assert_not @like1.valid?
  #  end
  #
  #  # 外部キーのため，Photoモデルで実装済み
  #  test "should require a photo_id" do
  #    @like1.photo_id = nil
  #    assert_not @like1.valid?
  #  end
end
