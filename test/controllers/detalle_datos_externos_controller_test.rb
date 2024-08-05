require 'test_helper'

class DetalleDatosExternosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @detalle_datos_externo = detalle_datos_externos(:one)
  end

  test "should get index" do
    get detalle_datos_externos_url
    assert_response :success
  end

  test "should get new" do
    get new_detalle_datos_externo_url
    assert_response :success
  end

  test "should create detalle_datos_externo" do
    assert_difference('DetalleDatosExterno.count') do
      post detalle_datos_externos_url, params: { detalle_datos_externo: { body: @detalle_datos_externo.body, datos_externo_id: @detalle_datos_externo.datos_externo_id, estado: @detalle_datos_externo.estado, nombre: @detalle_datos_externo.nombre, param1: @detalle_datos_externo.param1, param2: @detalle_datos_externo.param2, param3: @detalle_datos_externo.param3, param4: @detalle_datos_externo.param4, param5: @detalle_datos_externo.param5, tipo: @detalle_datos_externo.tipo, user_created_id: @detalle_datos_externo.user_created_id, user_updated_id: @detalle_datos_externo.user_updated_id } }
    end

    assert_redirected_to detalle_datos_externo_url(DetalleDatosExterno.last)
  end

  test "should show detalle_datos_externo" do
    get detalle_datos_externo_url(@detalle_datos_externo)
    assert_response :success
  end

  test "should get edit" do
    get edit_detalle_datos_externo_url(@detalle_datos_externo)
    assert_response :success
  end

  test "should update detalle_datos_externo" do
    patch detalle_datos_externo_url(@detalle_datos_externo), params: { detalle_datos_externo: { body: @detalle_datos_externo.body, datos_externo_id: @detalle_datos_externo.datos_externo_id, estado: @detalle_datos_externo.estado, nombre: @detalle_datos_externo.nombre, param1: @detalle_datos_externo.param1, param2: @detalle_datos_externo.param2, param3: @detalle_datos_externo.param3, param4: @detalle_datos_externo.param4, param5: @detalle_datos_externo.param5, tipo: @detalle_datos_externo.tipo, user_created_id: @detalle_datos_externo.user_created_id, user_updated_id: @detalle_datos_externo.user_updated_id } }
    assert_redirected_to detalle_datos_externo_url(@detalle_datos_externo)
  end

  test "should destroy detalle_datos_externo" do
    assert_difference('DetalleDatosExterno.count', -1) do
      delete detalle_datos_externo_url(@detalle_datos_externo)
    end

    assert_redirected_to detalle_datos_externos_url
  end
end
