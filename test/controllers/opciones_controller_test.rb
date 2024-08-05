require 'test_helper'

class OpcionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @opcion = opciones(:one)
  end

  test "should get index" do
    get opciones_url
    assert_response :success
  end

  test "should get new" do
    get new_opcion_url
    assert_response :success
  end

  test "should create opcion" do
    assert_difference('Opcion.count') do
      post opciones_url, params: { opcion: { controlador: @opcion.controlador, descripcion: @opcion.descripcion, estado: @opcion.estado, icono: @opcion.icono, menu_id: @opcion.menu_id, nombre: @opcion.nombre, path: @opcion.path, user_created_id: @opcion.user_created_id, user_updated_id: @opcion.user_updated_id } }
    end

    assert_redirected_to opcion_url(Opcion.last)
  end

  test "should show opcion" do
    get opcion_url(@opcion)
    assert_response :success
  end

  test "should get edit" do
    get edit_opcion_url(@opcion)
    assert_response :success
  end

  test "should update opcion" do
    patch opcion_url(@opcion), params: { opcion: { controlador: @opcion.controlador, descripcion: @opcion.descripcion, estado: @opcion.estado, icono: @opcion.icono, menu_id: @opcion.menu_id, nombre: @opcion.nombre, path: @opcion.path, user_created_id: @opcion.user_created_id, user_updated_id: @opcion.user_updated_id } }
    assert_redirected_to opcion_url(@opcion)
  end

  test "should destroy opcion" do
    assert_difference('Opcion.count', -1) do
      delete opcion_url(@opcion)
    end

    assert_redirected_to opciones_url
  end
end
