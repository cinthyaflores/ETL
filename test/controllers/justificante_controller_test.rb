# frozen_string_literal: true

require "test_helper"

class JustificanteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get justificante_index_url
    assert_response :success
  end
end
