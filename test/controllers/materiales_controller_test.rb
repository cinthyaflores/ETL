require 'test_helper'

class MaterialesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get materiales_index_url
    assert_response :success
  end

end
