require 'test_helper'

class PrestamosMaterialControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prestamos_material_index_url
    assert_response :success
  end

end
