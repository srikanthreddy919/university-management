require "application_system_test_case"

class Admin::ClassRoomsTest < ApplicationSystemTestCase
  setup do
    @admin_class_room = admin_class_rooms(:one)
  end

  test "visiting the index" do
    visit admin_class_rooms_url
    assert_selector "h1", text: "Admin/Class Rooms"
  end

  test "creating a Class room" do
    visit admin_class_rooms_url
    click_on "New Admin/Class Room"

    fill_in "Name", with: @admin_class_room.name
    click_on "Create Class room"

    assert_text "Class room was successfully created"
    click_on "Back"
  end

  test "updating a Class room" do
    visit admin_class_rooms_url
    click_on "Edit", match: :first

    fill_in "Name", with: @admin_class_room.name
    click_on "Update Class room"

    assert_text "Class room was successfully updated"
    click_on "Back"
  end

  test "destroying a Class room" do
    visit admin_class_rooms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Class room was successfully destroyed"
  end
end
