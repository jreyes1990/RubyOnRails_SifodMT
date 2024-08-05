require 'rails_helper'

RSpec.describe "datos_apis/new", type: :view do
  before(:each) do
    assign(:datos_api, DatosApi.new(
      nombre: "MyString",
      url_api: "MyString",
      token: "MyString",
      estado: "MyString",
      user_created_id: 1,
      user_updated_id: 1
    ))
  end

  it "renders new datos_api form" do
    render

    assert_select "form[action=?][method=?]", datos_apis_path, "post" do

      assert_select "input[name=?]", "datos_api[nombre]"

      assert_select "input[name=?]", "datos_api[url_api]"

      assert_select "input[name=?]", "datos_api[token]"

      assert_select "input[name=?]", "datos_api[estado]"

      assert_select "input[name=?]", "datos_api[user_created_id]"

      assert_select "input[name=?]", "datos_api[user_updated_id]"
    end
  end
end
