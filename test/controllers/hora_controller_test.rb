require 'test_helper'

class HoraControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hora_index_url
    assert_response :success
  end

end
