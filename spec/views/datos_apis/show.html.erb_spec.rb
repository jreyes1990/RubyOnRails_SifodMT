require 'rails_helper'

RSpec.describe "datos_apis/show", type: :view do
  before(:each) do
    @datos_api = assign(:datos_api, DatosApi.create!(
      nombre: "Nombre",
      url_api: "Url Api",
      token: "Token",
      estado: "Estado",
      user_created_id: 2,
      user_updated_id: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Url Api/)
    expect(rendered).to match(/Token/)
    expect(rendered).to match(/Estado/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
