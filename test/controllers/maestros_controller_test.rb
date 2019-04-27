# frozen_string_literal: true

require "test_helper"

class MaestrosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get maestros_index_url
    assert_response :success
  end

  test "should get edit" do
    get maestros_edit_url
    assert_response :success
  end

  test "should get update" do
    get maestros_update_url
    assert_response :success
  end

  test "should get delete" do
    get maestros_delete_url
    assert_response :success
  end
end
