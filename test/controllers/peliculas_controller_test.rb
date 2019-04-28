require 'test_helper'

class PeliculasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get peliculas_index_url
    assert_response :success
  end

end
