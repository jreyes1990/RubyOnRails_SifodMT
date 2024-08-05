require 'test_helper'

class DatosExternosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @datos_externo = datos_externos(:one)
  end

  test "should get index" do
    get datos_externos_url
    assert_response :success
  end

  test "should get new" do
    get new_datos_externo_url
    assert_response :success
  end

  test "should create datos_externo" do
    assert_difference('DatosExterno.count') do
      post datos_externos_url, params: { datos_externo: { estado: @datos_externo.estado, nombre: @datos_externo.nombre, token: @datos_externo.token, url_api: @datos_externo.url_api, user_created_id: @datos_externo.user_created_id, user_updated_id: @datos_externo.user_updated_id } }
    end

    assert_redirected_to datos_externo_url(DatosExterno.last)
  end

  test "should show datos_externo" do
    get datos_externo_url(@datos_externo)
    assert_response :success
  end

  test "should get edit" do
    get edit_datos_externo_url(@datos_externo)
    assert_response :success
  end

  test "should update datos_externo" do
    patch datos_externo_url(@datos_externo), params: { datos_externo: { estado: @datos_externo.estado, nombre: @datos_externo.nombre, token: @datos_externo.token, url_api: @datos_externo.url_api, user_created_id: @datos_externo.user_created_id, user_updated_id: @datos_externo.user_updated_id } }
    assert_redirected_to datos_externo_url(@datos_externo)
  end

  test "should destroy datos_externo" do
    assert_difference('DatosExterno.count', -1) do
      delete datos_externo_url(@datos_externo)
    end

    assert_redirected_to datos_externos_url
  end
end
