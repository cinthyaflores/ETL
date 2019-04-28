require 'test_helper'

class AlumnoGrupoInglesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get alumno_grupo_ingles_index_url
    assert_response :success
  end

end
