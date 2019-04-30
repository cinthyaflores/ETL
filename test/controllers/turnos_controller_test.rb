require 'test_helper'

class TurnosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get turnos_index_url
    assert_response :success
  end

end
