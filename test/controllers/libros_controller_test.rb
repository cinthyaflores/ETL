require 'test_helper'

class LibrosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get libros_index_url
    assert_response :success
  end

end
