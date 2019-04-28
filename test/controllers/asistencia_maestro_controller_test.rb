require 'test_helper'

class AsistenciaMaestroControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get asistencia_maestro_index_url
    assert_response :success
  end

end
