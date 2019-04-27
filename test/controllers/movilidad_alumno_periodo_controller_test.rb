# frozen_string_literal: true

require "test_helper"

class MovilidadAlumnoPeriodoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get movilidad_alumno_periodo_index_url
    assert_response :success
  end
end
