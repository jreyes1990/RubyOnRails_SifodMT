require "application_system_test_case"

class PersonaEmpresaFormulariosTest < ApplicationSystemTestCase
  setup do
    @persona_empresa_formulario = persona_empresa_formularios(:one)
  end

  test "visiting the index" do
    visit persona_empresa_formularios_url
    assert_selector "h1", text: "Persona Empresa Formularios"
  end

  test "creating a Persona empresa formulario" do
    visit persona_empresa_formularios_url
    click_on "New Persona Empresa Formulario"

    fill_in "Descripcion", with: @persona_empresa_formulario.descripcion
    fill_in "Estado", with: @persona_empresa_formulario.estado
    fill_in "Opcion ca", with: @persona_empresa_formulario.opcion_ca_id
    fill_in "Personas area", with: @persona_empresa_formulario.personas_area_id
    fill_in "User create", with: @persona_empresa_formulario.user_created_id
    fill_in "User update", with: @persona_empresa_formulario.user_updated_id
    click_on "Create Persona empresa formulario"

    assert_text "Persona empresa formulario was successfully created"
    click_on "Back"
  end

  test "updating a Persona empresa formulario" do
    visit persona_empresa_formularios_url
    click_on "Edit", match: :first

    fill_in "Descripcion", with: @persona_empresa_formulario.descripcion
    fill_in "Estado", with: @persona_empresa_formulario.estado
    fill_in "Opcion ca", with: @persona_empresa_formulario.opcion_ca_id
    fill_in "Personas area", with: @persona_empresa_formulario.personas_area_id
    fill_in "User create", with: @persona_empresa_formulario.user_created_id
    fill_in "User update", with: @persona_empresa_formulario.user_updated_id
    click_on "Update Persona empresa formulario"

    assert_text "Persona empresa formulario was successfully updated"
    click_on "Back"
  end

  test "destroying a Persona empresa formulario" do
    visit persona_empresa_formularios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Persona empresa formulario was successfully destroyed"
  end
end
