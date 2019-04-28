require 'test_helper'

class RevistasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get revistas_index_url
    assert_response :success
  end

end
