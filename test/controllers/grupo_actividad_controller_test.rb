require 'test_helper'

class GrupoActividadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get grupo_actividad_index_url
    assert_response :success
  end

  test "should get edit" do
    get grupo_actividad_edit_url
    assert_response :success
  end

  test "should get update" do
    get grupo_actividad_update_url
    assert_response :success
  end

  test "should get delete" do
    get grupo_actividad_delete_url
    assert_response :success
  end

end
