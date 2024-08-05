require 'test_helper'

class PersonasAreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @personas_area = personas_areas(:one)
  end

  test "should get index" do
    get personas_areas_url
    assert_response :success
  end

  test "should get new" do
    get new_personas_area_url
    assert_response :success
  end

  test "should create personas_area" do
    assert_difference('PersonasArea.count') do
      post personas_areas_url, params: { personas_area: { areas: @personas_area.areas, estado: @personas_area.estado, personas: @personas_area.personas, user_created_id: @personas_area.user_created_id, user_updated_id: @personas_area.user_updated_id } }
    end

    assert_redirected_to personas_area_url(PersonasArea.last)
  end

  test "should show personas_area" do
    get personas_area_url(@personas_area)
    assert_response :success
  end

  test "should get edit" do
    get edit_personas_area_url(@personas_area)
    assert_response :success
  end

  test "should update personas_area" do
    patch personas_area_url(@personas_area), params: { personas_area: { areas: @personas_area.areas, estado: @personas_area.estado, personas: @personas_area.personas, user_created_id: @personas_area.user_created_id, user_updated_id: @personas_area.user_updated_id } }
    assert_redirected_to personas_area_url(@personas_area)
  end

  test "should destroy personas_area" do
    assert_difference('PersonasArea.count', -1) do
      delete personas_area_url(@personas_area)
    end

    assert_redirected_to personas_areas_url
  end
end
