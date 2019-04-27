# frozen_string_literal: true

require "test_helper"

class MovilidadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get movilidad_index_url
    assert_response :success
  end

  test "should get edit" do
    get movilidad_edit_url
    assert_response :success
  end
end
