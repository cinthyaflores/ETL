require 'test_helper'

class AlumnoGrupoActividadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get alumno_grupo_actividad_index_url
    assert_response :success
  end

end
