require 'test_helper'

class SeccioneseesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get seccionesees_index_url
    assert_response :success
  end

end
