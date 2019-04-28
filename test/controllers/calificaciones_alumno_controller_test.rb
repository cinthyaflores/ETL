require 'test_helper'

class CalificacionesAlumnoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calificaciones_alumno_index_url
    assert_response :success
  end

end
