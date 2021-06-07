require 'test_helper'

class ItemCommentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get item_comment_create_url
    assert_response :success
  end

  test "should get destroy" do
    get item_comment_destroy_url
    assert_response :success
  end

end
