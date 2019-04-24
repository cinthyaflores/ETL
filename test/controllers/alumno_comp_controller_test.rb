require 'test_helper'

class AlumnoCompControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get alumno_comp_index_url
    assert_response :success
  end

end
