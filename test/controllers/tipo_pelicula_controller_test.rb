require 'test_helper'

class TipoPeliculaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tipo_pelicula_index_url
    assert_response :success
  end

end
