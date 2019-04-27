# frozen_string_literal: true

require "test_helper"

class TipoBajaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tipo_baja_index_url
    assert_response :success
  end
end
