# frozen_string_literal: true

require "test_helper"

class TipoConstanciaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tipo_constancia_index_url
    assert_response :success
  end
end
