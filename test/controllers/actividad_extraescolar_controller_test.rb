require 'test_helper'

class ActividadExtraescolarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get actividad_extraescolar_index_url
    assert_response :success
  end

end
