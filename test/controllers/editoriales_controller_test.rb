require 'test_helper'

class EditorialesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get editoriales_index_url
    assert_response :success
  end

end
