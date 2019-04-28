require 'test_helper'

class ActividadesPorAlumnoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get actividades_por_alumno_index_url
    assert_response :success
  end

end
