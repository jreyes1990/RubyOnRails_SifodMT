require 'rails_helper'

RSpec.describe "datos_apis/index", type: :view do
  before(:each) do
    assign(:datos_apis, [
      DatosApi.create!(
        nombre: "Nombre",
        url_api: "Url Api",
        token: "Token",
        estado: "Estado",
        user_created_id: 2,
        user_updated_id: 3
      ),
      DatosApi.create!(
        nombre: "Nombre",
        url_api: "Url Api",
        token: "Token",
        estado: "Estado",
        user_created_id: 2,
        user_updated_id: 3
      )
    ])
  end

  it "renders a list of datos_apis" do
    render
    assert_select "tr>td", text: "Nombre".to_s, count: 2
    assert_select "tr>td", text: "Url Api".to_s, count: 2
    assert_select "tr>td", text: "Token".to_s, count: 2
    assert_select "tr>td", text: "Estado".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
