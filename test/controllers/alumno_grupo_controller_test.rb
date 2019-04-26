require 'test_helper'

class AlumnoGrupoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get alumno_grupo_index_url
    assert_response :success
  end

end
