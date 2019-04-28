require 'test_helper'

class IdiomasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get idiomas_index_url
    assert_response :success
  end

end
