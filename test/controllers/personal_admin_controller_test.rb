# frozen_string_literal: true

require "test_helper"

class PersonalAdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get personal_admin_index_url
    assert_response :success
  end

  test "should get edit" do
    get personal_admin_edit_url
    assert_response :success
  end
end
