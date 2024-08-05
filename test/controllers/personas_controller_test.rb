require 'test_helper'

class PersonasControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get personas_show_url
    assert_response :success
  end

  test "should get edit" do
    get personas_edit_url
    assert_response :success
  end

end
