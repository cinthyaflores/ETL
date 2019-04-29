require 'test_helper'

class HardwareMantenimientoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hardware_mantenimiento_index_url
    assert_response :success
  end

end
