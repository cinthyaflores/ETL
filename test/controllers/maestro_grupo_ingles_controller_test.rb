require 'test_helper'

class MaestroGrupoInglesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get maestro_grupo_ingles_index_url
    assert_response :success
  end

end
