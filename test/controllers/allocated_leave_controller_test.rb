require 'test_helper'

class AllocatedLeaveControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get allocated_leave_index_url
    assert_response :success
  end

  test "should get newcreate" do
    get allocated_leave_newcreate_url
    assert_response :success
  end

  test "should get edit" do
    get allocated_leave_edit_url
    assert_response :success
  end

  test "should get show" do
    get allocated_leave_show_url
    assert_response :success
  end

  test "should get update" do
    get allocated_leave_update_url
    assert_response :success
  end

  test "should get destroy" do
    get allocated_leave_destroy_url
    assert_response :success
  end

end
