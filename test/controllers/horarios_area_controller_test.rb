require 'test_helper'

class HorariosAreaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get horarios_area_index_url
    assert_response :success
  end

end
