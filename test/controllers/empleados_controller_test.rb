require 'test_helper'

class EmpleadosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get empleados_index_url
    assert_response :success
  end

  test "should get edit" do
    get empleados_edit_url
    assert_response :success
  end

end
