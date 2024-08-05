require 'test_helper'

class PersonaEmpresaFormulariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @persona_empresa_formulario = persona_empresa_formularios(:one)
  end

  test "should get index" do
    get persona_empresa_formularios_url
    assert_response :success
  end

  test "should get new" do
    get new_persona_empresa_formulario_url
    assert_response :success
  end

  test "should create persona_empresa_formulario" do
    assert_difference('PersonaEmpresaFormulario.count') do
      post persona_empresa_formularios_url, params: { persona_empresa_formulario: { descripcion: @persona_empresa_formulario.descripcion, estado: @persona_empresa_formulario.estado, opcion_ca_id: @persona_empresa_formulario.opcion_ca_id, personas_area_id: @persona_empresa_formulario.personas_area_id, user_created_id: @persona_empresa_formulario.user_created_id, user_updated_id: @persona_empresa_formulario.user_updated_id } }
    end

    assert_redirected_to persona_empresa_formulario_url(PersonaEmpresaFormulario.last)
  end

  test "should show persona_empresa_formulario" do
    get persona_empresa_formulario_url(@persona_empresa_formulario)
    assert_response :success
  end

  test "should get edit" do
    get edit_persona_empresa_formulario_url(@persona_empresa_formulario)
    assert_response :success
  end

  test "should update persona_empresa_formulario" do
    patch persona_empresa_formulario_url(@persona_empresa_formulario), params: { persona_empresa_formulario: { descripcion: @persona_empresa_formulario.descripcion, estado: @persona_empresa_formulario.estado, opcion_ca_id: @persona_empresa_formulario.opcion_ca_id, personas_area_id: @persona_empresa_formulario.personas_area_id, user_created_id: @persona_empresa_formulario.user_created_id, user_updated_id: @persona_empresa_formulario.user_updated_id } }
    assert_redirected_to persona_empresa_formulario_url(@persona_empresa_formulario)
  end

  test "should destroy persona_empresa_formulario" do
    assert_difference('PersonaEmpresaFormulario.count', -1) do
      delete persona_empresa_formulario_url(@persona_empresa_formulario)
    end

    assert_redirected_to persona_empresa_formularios_url
  end
end
