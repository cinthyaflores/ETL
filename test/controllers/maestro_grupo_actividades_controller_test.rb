require 'test_helper'

class MaestroGrupoActividadesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get maestro_grupo_actividades_index_url
    assert_response :success
  end

end
