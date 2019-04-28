require 'test_helper'

class AsistenciaAlumnoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get asistencia_alumno_index_url
    assert_response :success
  end

end
