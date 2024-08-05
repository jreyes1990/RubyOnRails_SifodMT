require "application_system_test_case"

class ComponentesTest < ApplicationSystemTestCase
  setup do
    @componente = componentes(:one)
  end

  test "visiting the index" do
    visit componentes_url
    assert_selector "h1", text: "Componentes"
  end

  test "creating a Componente" do
    visit componentes_url
    click_on "New Componente"

    fill_in "Descripcion", with: @componente.descripcion
    fill_in "Estado", with: @componente.estado
    fill_in "Nombre", with: @componente.nombre
    fill_in "User create", with: @componente.user_created_id
    fill_in "User update", with: @componente.user_updated_id
    click_on "Create Componente"

    assert_text "Componente was successfully created"
    click_on "Back"
  end

  test "updating a Componente" do
    visit componentes_url
    click_on "Edit", match: :first

    fill_in "Descripcion", with: @componente.descripcion
    fill_in "Estado", with: @componente.estado
    fill_in "Nombre", with: @componente.nombre
    fill_in "User create", with: @componente.user_created_id
    fill_in "User update", with: @componente.user_updated_id
    click_on "Update Componente"

    assert_text "Componente was successfully updated"
    click_on "Back"
  end

  test "destroying a Componente" do
    visit componentes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Componente was successfully destroyed"
  end
end
