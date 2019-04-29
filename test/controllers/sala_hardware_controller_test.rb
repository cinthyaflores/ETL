require 'test_helper'

class SalaHardwareControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sala_hardware_index_url
    assert_response :success
  end

end
