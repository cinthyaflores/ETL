require 'test_helper'

class EvaluacionesIngresoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get evaluaciones_ingreso_index_url
    assert_response :success
  end

end
