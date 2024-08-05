require "application_system_test_case"

class OpcionCasTest < ApplicationSystemTestCase
  setup do
    @opcion_ca = opcion_cas(:one)
  end

  test "visiting the index" do
    visit opcion_cas_url
    assert_selector "h1", text: "Opcion Cas"
  end

  test "creating a Opcion ca" do
    visit opcion_cas_url
    click_on "New Opcion Ca"

    fill_in "Atributo", with: @opcion_ca.atributo_id
    fill_in "Componente", with: @opcion_ca.componente_id
    fill_in "Descripcion", with: @opcion_ca.descripcion
    fill_in "Estado", with: @opcion_ca.estado
    fill_in "Opcion", with: @opcion_ca.opcion_id
    fill_in "User create", with: @opcion_ca.user_created_id
    fill_in "User update", with: @opcion_ca.user_updated_id
    click_on "Create Opcion ca"

    assert_text "Opcion ca was successfully created"
    click_on "Back"
  end

  test "updating a Opcion ca" do
    visit opcion_cas_url
    click_on "Edit", match: :first

    fill_in "Atributo", with: @opcion_ca.atributo_id
    fill_in "Componente", with: @opcion_ca.componente_id
    fill_in "Descripcion", with: @opcion_ca.descripcion
    fill_in "Estado", with: @opcion_ca.estado
    fill_in "Opcion", with: @opcion_ca.opcion_id
    fill_in "User create", with: @opcion_ca.user_created_id
    fill_in "User update", with: @opcion_ca.user_updated_id
    click_on "Update Opcion ca"

    assert_text "Opcion ca was successfully updated"
    click_on "Back"
  end

  test "destroying a Opcion ca" do
    visit opcion_cas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Opcion ca was successfully destroyed"
  end
end
