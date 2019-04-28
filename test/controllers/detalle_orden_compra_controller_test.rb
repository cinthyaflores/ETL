require 'test_helper'

class DetalleOrdenCompraControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get detalle_orden_compra_index_url
    assert_response :success
  end

end
