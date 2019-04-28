require 'test_helper'

class EventosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get eventos_index_url
    assert_response :success
  end

end
