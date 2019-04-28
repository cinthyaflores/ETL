require 'test_helper'

class AlumnosExternosInglesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get alumnos_externos_ingles_index_url
    assert_response :success
  end

end
