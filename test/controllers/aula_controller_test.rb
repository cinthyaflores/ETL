require 'test_helper'

class AulaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get aula_index_url
    assert_response :success
  end

end
