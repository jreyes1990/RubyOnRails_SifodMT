require 'test_helper'

class OpcionCasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @opcion_ca = opcion_cas(:one)
  end

  test "should get index" do
    get opcion_cas_url
    assert_response :success
  end

  test "should get new" do
    get new_opcion_ca_url
    assert_response :success
  end

  test "should create opcion_ca" do
    assert_difference('OpcionCa.count') do
      post opcion_cas_url, params: { opcion_ca: { atributo_id: @opcion_ca.atributo_id, componente_id: @opcion_ca.componente_id, descripcion: @opcion_ca.descripcion, estado: @opcion_ca.estado, opcion_id: @opcion_ca.opcion_id, user_created_id: @opcion_ca.user_created_id, user_updated_id: @opcion_ca.user_updated_id } }
    end

    assert_redirected_to opcion_ca_url(OpcionCa.last)
  end

  test "should show opcion_ca" do
    get opcion_ca_url(@opcion_ca)
    assert_response :success
  end

  test "should get edit" do
    get edit_opcion_ca_url(@opcion_ca)
    assert_response :success
  end

  test "should update opcion_ca" do
    patch opcion_ca_url(@opcion_ca), params: { opcion_ca: { atributo_id: @opcion_ca.atributo_id, componente_id: @opcion_ca.componente_id, descripcion: @opcion_ca.descripcion, estado: @opcion_ca.estado, opcion_id: @opcion_ca.opcion_id, user_created_id: @opcion_ca.user_created_id, user_updated_id: @opcion_ca.user_updated_id } }
    assert_redirected_to opcion_ca_url(@opcion_ca)
  end

  test "should destroy opcion_ca" do
    assert_difference('OpcionCa.count', -1) do
      delete opcion_ca_url(@opcion_ca)
    end

    assert_redirected_to opcion_cas_url
  end
end
