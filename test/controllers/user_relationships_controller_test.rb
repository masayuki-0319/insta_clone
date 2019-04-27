require 'test_helper'

class UserRelationshipsControllerTest < ActionDispatch::IntegrationTest

  test "create should require logged-in user" do
    assert_no_difference 'UserRelationship.count' do
      post user_relationships_path
    end
    assert_redirected_to new_user_session_path
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'UserRelationship.count' do
      delete user_relationship_path(user_relationships(:one))
    end
    assert_redirected_to new_user_session_path
  end
end
