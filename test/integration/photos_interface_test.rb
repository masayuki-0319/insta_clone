require 'test_helper'

class PhotosInterfaceTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @user = users(:aoi)
  end

  test "photo interface" do
    login_as(@user, scope: :user)
    get root_path
    assert_select 'input[type = file]'
    # 無効な送信
    assert_no_difference 'Photo.count' do
      post photos_path, params: { photo: { title: "sample" } }
    end
    # 有効な送信
    title = "Test valid post"
    picture = fixture_file_upload('test/fixtures/files/rails.png', 'image/png')
    assert_difference 'Photo.count', 1 do
      post photos_path, params: { photo: { picture: picture,
                                           title: title } }
    end
    assert_redirected_to photo_path(Photo.first.id)
    follow_redirect!
    assert_match title, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_photo = @user.photos.paginate(page: 1).first
    assert_difference 'Photo.count', -1 do
      delete photo_path(first_photo)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:hinata))
    assert_select 'a', text: 'delete', count: 0
  end

  # 投稿数計測のテスト：ユーザー情報フォームを作成後に転記する
  #test "micropost sidebar count" do
  #  login_as(@user, scope: :user)
  #  get root_path
  #  # 未投稿ユーザー
  #  other_user = users(:hinata)
  #  log_in_as(other_user)
  #  get root_path
  #  assert_match "0 photos", response.body
  #  title = "Test valid post"
  #  picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
  #  other_user.photos.create!(picture: picture, title: title )
  #  get root_path
  #end
end
