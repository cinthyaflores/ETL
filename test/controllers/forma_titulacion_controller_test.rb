require 'test_helper'

class FormaTitulacionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forma_titulacion_index_url
    assert_response :success
  end

end
