require 'test_helper'

class SalaTrabajoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sala_trabajo_index_url
    assert_response :success
  end

end
