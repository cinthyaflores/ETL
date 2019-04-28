require 'test_helper'

class NivelInglesAlumnoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nivel_ingles_alumno_index_url
    assert_response :success
  end

end
