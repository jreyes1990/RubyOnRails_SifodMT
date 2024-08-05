require "application_system_test_case"

class MenuRolsTest < ApplicationSystemTestCase
  setup do
    @menu_rol = menu_roles(:one)
  end

  test "visiting the index" do
    visit menu_roles_url
    assert_selector "h1", text: "Menu roles"
  end

  test "creating a Menu rol" do
    visit menu_roles_url
    click_on "New Menu Rol"

    fill_in "Estado", with: @menu_rol.estado
    fill_in "Menu padre", with: @menu_rol.menu_padre
    fill_in "Opcion", with: @menu_rol.opcion_id
    fill_in "Rol", with: @menu_rol.rol_id
    fill_in "User create", with: @menu_rol.user_created_id
    fill_in "User update", with: @menu_rol.user_updated_id
    click_on "Create Menu rol"

    assert_text "Menu rol was successfully created"
    click_on "Back"
  end

  test "updating a Menu rol" do
    visit menu_roles_url
    click_on "Edit", match: :first

    fill_in "Estado", with: @menu_rol.estado
    fill_in "Menu padre", with: @menu_rol.menu_padre
    fill_in "Opcion", with: @menu_rol.opcion_id
    fill_in "Rol", with: @menu_rol.rol_id
    fill_in "User create", with: @menu_rol.user_created_id
    fill_in "User update", with: @menu_rol.user_updated_id
    click_on "Update Menu rol"

    assert_text "Menu rol was successfully updated"
    click_on "Back"
  end

  test "destroying a Menu rol" do
    visit menu_roles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Menu rol was successfully destroyed"
  end
end
