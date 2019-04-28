require 'test_helper'

class EventosAlumnoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get eventos_alumno_index_url
    assert_response :success
  end

end
