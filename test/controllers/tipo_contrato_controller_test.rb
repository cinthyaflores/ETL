# frozen_string_literal: true

require "test_helper"

class TipoContratoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tipo_contrato_index_url
    assert_response :success
  end
end
