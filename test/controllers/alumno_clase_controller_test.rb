require 'test_helper'

class AlumnoClaseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get alumno_clase_index_url
    assert_response :success
  end

end
