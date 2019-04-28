require 'test_helper'

class PerdidasMaterialesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get perdidas_materiales_index_url
    assert_response :success
  end

end
