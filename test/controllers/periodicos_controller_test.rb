require 'test_helper'

class PeriodicosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get periodicos_index_url
    assert_response :success
  end

end
