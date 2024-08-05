require "application_system_test_case"

class AtributosTest < ApplicationSystemTestCase
  setup do
    @atributo = atributos(:one)
  end

  test "visiting the index" do
    visit atributos_url
    assert_selector "h1", text: "Atributos"
  end

  test "creating a Atributo" do
    visit atributos_url
    click_on "New Atributo"

    fill_in "Descripcion", with: @atributo.descripcion
    fill_in "Estado", with: @atributo.estado
    fill_in "Nombre", with: @atributo.nombre
    fill_in "User create", with: @atributo.user_created_id
    fill_in "User update", with: @atributo.user_updated_id
    click_on "Create Atributo"

    assert_text "Atributo was successfully created"
    click_on "Back"
  end

  test "updating a Atributo" do
    visit atributos_url
    click_on "Edit", match: :first

    fill_in "Descripcion", with: @atributo.descripcion
    fill_in "Estado", with: @atributo.estado
    fill_in "Nombre", with: @atributo.nombre
    fill_in "User create", with: @atributo.user_created_id
    fill_in "User update", with: @atributo.user_updated_id
    click_on "Update Atributo"

    assert_text "Atributo was successfully updated"
    click_on "Back"
  end

  test "destroying a Atributo" do
    visit atributos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Atributo was successfully destroyed"
  end
end
