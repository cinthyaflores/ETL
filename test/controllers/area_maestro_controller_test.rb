# frozen_string_literal: true

require "test_helper"

class AreaMaestroControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get area_maestro_index_url
    assert_response :success
  end
end
