# frozen_string_literal: true

require "test_helper"

class CarreraControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get carrera_index_url
    assert_response :success
  end
end
