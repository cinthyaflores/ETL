# frozen_string_literal: true

require "test_helper"

class TituladoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get titulado_index_url
    assert_response :success
  end
end
