require 'test_helper'

class OrdenDeCompraControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orden_de_compra_index_url
    assert_response :success
  end

end
