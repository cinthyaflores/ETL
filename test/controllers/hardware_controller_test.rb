require 'test_helper'

class HardwareControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hardware_index_url
    assert_response :success
  end

end
