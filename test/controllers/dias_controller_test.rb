require 'test_helper'

class DiasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dias_index_url
    assert_response :success
  end

end
