require 'test_helper'

class SoftwareControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get software_index_url
    assert_response :success
  end

end
