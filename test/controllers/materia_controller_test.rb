require 'test_helper'

class MateriaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get materia_index_url
    assert_response :success
  end

end
