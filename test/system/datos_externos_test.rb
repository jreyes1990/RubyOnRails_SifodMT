require "application_system_test_case"

class DatosExternosTest < ApplicationSystemTestCase
  setup do
    @datos_externo = datos_externos(:one)
  end

  test "visiting the index" do
    visit datos_externos_url
    assert_selector "h1", text: "Datos Externos"
  end

  test "creating a Datos externo" do
    visit datos_externos_url
    click_on "New Datos Externo"

    fill_in "Estado", with: @datos_externo.estado
    fill_in "Nombre", with: @datos_externo.nombre
    fill_in "Token", with: @datos_externo.token
    fill_in "Url api", with: @datos_externo.url_api
    fill_in "User create", with: @datos_externo.user_created_id
    fill_in "User update", with: @datos_externo.user_updated_id
    click_on "Create Datos externo"

    assert_text "Datos externo was successfully created"
    click_on "Back"
  end

  test "updating a Datos externo" do
    visit datos_externos_url
    click_on "Edit", match: :first

    fill_in "Estado", with: @datos_externo.estado
    fill_in "Nombre", with: @datos_externo.nombre
    fill_in "Token", with: @datos_externo.token
    fill_in "Url api", with: @datos_externo.url_api
    fill_in "User create", with: @datos_externo.user_created_id
    fill_in "User update", with: @datos_externo.user_updated_id
    click_on "Update Datos externo"

    assert_text "Datos externo was successfully updated"
    click_on "Back"
  end

  test "destroying a Datos externo" do
    visit datos_externos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Datos externo was successfully destroyed"
  end
end
