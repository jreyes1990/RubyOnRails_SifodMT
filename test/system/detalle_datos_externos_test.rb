require "application_system_test_case"

class DetalleDatosExternosTest < ApplicationSystemTestCase
  setup do
    @detalle_datos_externo = detalle_datos_externos(:one)
  end

  test "visiting the index" do
    visit detalle_datos_externos_url
    assert_selector "h1", text: "Detalle Datos Externos"
  end

  test "creating a Detalle datos externo" do
    visit detalle_datos_externos_url
    click_on "New Detalle Datos Externo"

    fill_in "Body", with: @detalle_datos_externo.body
    fill_in "Datos externo", with: @detalle_datos_externo.datos_externo_id
    fill_in "Estado", with: @detalle_datos_externo.estado
    fill_in "Nombre", with: @detalle_datos_externo.nombre
    fill_in "Param1", with: @detalle_datos_externo.param1
    fill_in "Param2", with: @detalle_datos_externo.param2
    fill_in "Param3", with: @detalle_datos_externo.param3
    fill_in "Param4", with: @detalle_datos_externo.param4
    fill_in "Param5", with: @detalle_datos_externo.param5
    fill_in "Tipo", with: @detalle_datos_externo.tipo
    fill_in "User create", with: @detalle_datos_externo.user_created_id
    fill_in "User update", with: @detalle_datos_externo.user_updated_id
    click_on "Create Detalle datos externo"

    assert_text "Detalle datos externo was successfully created"
    click_on "Back"
  end

  test "updating a Detalle datos externo" do
    visit detalle_datos_externos_url
    click_on "Edit", match: :first

    fill_in "Body", with: @detalle_datos_externo.body
    fill_in "Datos externo", with: @detalle_datos_externo.datos_externo_id
    fill_in "Estado", with: @detalle_datos_externo.estado
    fill_in "Nombre", with: @detalle_datos_externo.nombre
    fill_in "Param1", with: @detalle_datos_externo.param1
    fill_in "Param2", with: @detalle_datos_externo.param2
    fill_in "Param3", with: @detalle_datos_externo.param3
    fill_in "Param4", with: @detalle_datos_externo.param4
    fill_in "Param5", with: @detalle_datos_externo.param5
    fill_in "Tipo", with: @detalle_datos_externo.tipo
    fill_in "User create", with: @detalle_datos_externo.user_created_id
    fill_in "User update", with: @detalle_datos_externo.user_updated_id
    click_on "Update Detalle datos externo"

    assert_text "Detalle datos externo was successfully updated"
    click_on "Back"
  end

  test "destroying a Detalle datos externo" do
    visit detalle_datos_externos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Detalle datos externo was successfully destroyed"
  end
end
