# frozen_string_literal: true

require "test_helper"

class GrupoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get grupo_index_url
    assert_response :success
  end

  test "should get edit" do
    get grupo_edit_url
    assert_response :success
  end

  test "should get update" do
    get grupo_update_url
    assert_response :success
  end

  test "should get destroy" do
    get grupo_destroy_url
    assert_response :success
  end
end
