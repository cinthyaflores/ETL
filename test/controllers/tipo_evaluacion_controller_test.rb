require 'test_helper'

class TipoEvaluacionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tipo_evaluacion_index_url
    assert_response :success
  end

  test "should get edit" do
    get tipo_evaluacion_edit_url
    assert_response :success
  end

end
