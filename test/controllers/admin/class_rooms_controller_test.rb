require 'test_helper'

class Admin::ClassRoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_class_room = admin_class_rooms(:one)
  end

  test "should get index" do
    get admin_class_rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_class_room_url
    assert_response :success
  end

  test "should create admin_class_room" do
    assert_difference('Admin::ClassRoom.count') do
      post admin_class_rooms_url, params: { admin_class_room: { name: @admin_class_room.name } }
    end

    assert_redirected_to admin_class_room_url(Admin::ClassRoom.last)
  end

  test "should show admin_class_room" do
    get admin_class_room_url(@admin_class_room)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_class_room_url(@admin_class_room)
    assert_response :success
  end

  test "should update admin_class_room" do
    patch admin_class_room_url(@admin_class_room), params: { admin_class_room: { name: @admin_class_room.name } }
    assert_redirected_to admin_class_room_url(@admin_class_room)
  end

  test "should destroy admin_class_room" do
    assert_difference('Admin::ClassRoom.count', -1) do
      delete admin_class_room_url(@admin_class_room)
    end

    assert_redirected_to admin_class_rooms_url
  end
end
