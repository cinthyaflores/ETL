require 'test_helper'

class EstanteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get estante_index_url
    assert_response :success
  end

end
