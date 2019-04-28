require 'test_helper'

class PrestamosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prestamos_index_url
    assert_response :success
  end

end
