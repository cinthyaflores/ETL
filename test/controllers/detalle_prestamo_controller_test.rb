require 'test_helper'

class DetallePrestamoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get detalle_prestamo_index_url
    assert_response :success
  end

end
