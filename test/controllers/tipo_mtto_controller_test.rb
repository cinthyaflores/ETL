require 'test_helper'

class TipoMttoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tipo_mtto_index_url
    assert_response :success
  end

end
