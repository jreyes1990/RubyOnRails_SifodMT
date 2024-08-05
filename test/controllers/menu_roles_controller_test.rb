require 'test_helper'

class MenuRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menu_rol = menu_roles(:one)
  end

  test "should get index" do
    get menu_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_menu_rol_url
    assert_response :success
  end

  test "should create menu_rol" do
    assert_difference('MenuRol.count') do
      post menu_roles_url, params: { menu_rol: { estado: @menu_rol.estado, menu_padre: @menu_rol.menu_padre, opcion_id: @menu_rol.opcion_id, rol_id: @menu_rol.rol_id, user_created_id: @menu_rol.user_created_id, user_updated_id: @menu_rol.user_updated_id } }
    end

    assert_redirected_to menu_rol_url(MenuRol.last)
  end

  test "should show menu_rol" do
    get menu_rol_url(@menu_rol)
    assert_response :success
  end

  test "should get edit" do
    get edit_menu_rol_url(@menu_rol)
    assert_response :success
  end

  test "should update menu_rol" do
    patch menu_rol_url(@menu_rol), params: { menu_rol: { estado: @menu_rol.estado, menu_padre: @menu_rol.menu_padre, opcion_id: @menu_rol.opcion_id, rol_id: @menu_rol.rol_id, user_created_id: @menu_rol.user_created_id, user_updated_id: @menu_rol.user_updated_id } }
    assert_redirected_to menu_rol_url(@menu_rol)
  end

  test "should destroy menu_rol" do
    assert_difference('MenuRol.count', -1) do
      delete menu_rol_url(@menu_rol)
    end

    assert_redirected_to menu_roles_url
  end
end
