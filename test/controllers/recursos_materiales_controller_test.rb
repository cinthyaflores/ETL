require 'test_helper'

class RecursosMaterialesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recursos_materiales_index_url
    assert_response :success
  end

end
