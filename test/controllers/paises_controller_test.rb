require 'test_helper'

class PaisesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get paises_index_url
    assert_response :success
  end

end
