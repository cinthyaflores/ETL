require 'test_helper'

class AreaRecreativaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get area_recreativa_index_url
    assert_response :success
  end

end
