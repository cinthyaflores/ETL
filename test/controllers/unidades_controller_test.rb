require 'test_helper'

class UnidadesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get unidades_index_url
    assert_response :success
  end

end
