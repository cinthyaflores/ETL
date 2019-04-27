# frozen_string_literal: true

require "test_helper"

class BajasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bajas_index_url
    assert_response :success
  end
end
