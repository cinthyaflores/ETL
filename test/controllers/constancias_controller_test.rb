# frozen_string_literal: true

require "test_helper"

class ConstanciasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get constancias_index_url
    assert_response :success
  end
end
