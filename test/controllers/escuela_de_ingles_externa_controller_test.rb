require 'test_helper'

class EscuelaDeInglesExternaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get escuela_de_ingles_externa_index_url
    assert_response :success
  end

end
