# frozen_string_literal: true

require "test_helper"

class CambioCarreraControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cambio_carrera_index_url
    assert_response :success
  end
end
