require 'test_helper'

class UserRelationshipTest < ActiveSupport::TestCase

  def setup
    @user_relationship = UserRelationship.new(
      follower_id: users(:aoi).id, followed_id: users(:hinata).id)
  end

  test "should be valid" do
    assert @user_relationship.valid?
  end

  test "should require a follower_id" do
    @user_relationship.follower_id = nil
    assert_not @user_relationship.valid?
  end

  test "should require a followed_id" do
    @user_relationship.followed_id = nil
    assert_not @user_relationship.valid?
  end
end
