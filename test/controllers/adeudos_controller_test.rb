require 'test_helper'

class AdeudosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get adeudos_index_url
    assert_response :success
  end

  test "should get edit" do
    get adeudos_edit_url
    assert_response :success
  end

end
