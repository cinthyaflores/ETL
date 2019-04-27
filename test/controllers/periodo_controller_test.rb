# frozen_string_literal: true

require "test_helper"

class PeriodoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get periodo_index_url
    assert_response :success
  end
end
