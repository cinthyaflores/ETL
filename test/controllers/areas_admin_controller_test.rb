# frozen_string_literal: true

require "test_helper"

class AreasAdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get areas_admin_index_url
    assert_response :success
  end
end
