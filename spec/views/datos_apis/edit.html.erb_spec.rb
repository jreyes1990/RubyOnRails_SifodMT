require 'rails_helper'

RSpec.describe "datos_apis/edit", type: :view do
  before(:each) do
    @datos_api = assign(:datos_api, DatosApi.create!(
      nombre: "MyString",
      url_api: "MyString",
      token: "MyString",
      estado: "MyString",
      user_created_id: 1,
      user_updated_id: 1
    ))
  end

  it "renders the edit datos_api form" do
    render

    assert_select "form[action=?][method=?]", datos_api_path(@datos_api), "post" do

      assert_select "input[name=?]", "datos_api[nombre]"

      assert_select "input[name=?]", "datos_api[url_api]"

      assert_select "input[name=?]", "datos_api[token]"

      assert_select "input[name=?]", "datos_api[estado]"

      assert_select "input[name=?]", "datos_api[user_created_id]"

      assert_select "input[name=?]", "datos_api[user_updated_id]"
    end
  end
end
