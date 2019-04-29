require 'test_helper'

class PrestamosSalaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prestamos_sala_index_url
    assert_response :success
  end

end
