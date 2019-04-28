require 'test_helper'

class ProductorasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get productoras_index_url
    assert_response :success
  end

end
