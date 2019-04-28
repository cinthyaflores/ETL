require 'test_helper'

class NivelDeInglesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nivel_de_ingles_index_url
    assert_response :success
  end

end
