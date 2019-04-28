require 'test_helper'

class GrupoInglesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get grupo_ingles_index_url
    assert_response :success
  end

end
