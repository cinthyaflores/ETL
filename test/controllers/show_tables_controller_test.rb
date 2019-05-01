require 'test_helper'

class ShowTablesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get show_tables_index_url
    assert_response :success
  end

end
