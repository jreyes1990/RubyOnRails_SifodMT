require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/tipo_contenidos", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # TipoContenido. As you add validations to TipoContenido, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      TipoContenido.create! valid_attributes
      get tipo_contenidos_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      tipo_contenido = TipoContenido.create! valid_attributes
      get tipo_contenido_url(tipo_contenido)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_tipo_contenido_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      tipo_contenido = TipoContenido.create! valid_attributes
      get edit_tipo_contenido_url(tipo_contenido)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new TipoContenido" do
        expect {
          post tipo_contenidos_url, params: { tipo_contenido: valid_attributes }
        }.to change(TipoContenido, :count).by(1)
      end

      it "redirects to the created tipo_contenido" do
        post tipo_contenidos_url, params: { tipo_contenido: valid_attributes }
        expect(response).to redirect_to(tipo_contenido_url(TipoContenido.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new TipoContenido" do
        expect {
          post tipo_contenidos_url, params: { tipo_contenido: invalid_attributes }
        }.to change(TipoContenido, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post tipo_contenidos_url, params: { tipo_contenido: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested tipo_contenido" do
        tipo_contenido = TipoContenido.create! valid_attributes
        patch tipo_contenido_url(tipo_contenido), params: { tipo_contenido: new_attributes }
        tipo_contenido.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the tipo_contenido" do
        tipo_contenido = TipoContenido.create! valid_attributes
        patch tipo_contenido_url(tipo_contenido), params: { tipo_contenido: new_attributes }
        tipo_contenido.reload
        expect(response).to redirect_to(tipo_contenido_url(tipo_contenido))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        tipo_contenido = TipoContenido.create! valid_attributes
        patch tipo_contenido_url(tipo_contenido), params: { tipo_contenido: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested tipo_contenido" do
      tipo_contenido = TipoContenido.create! valid_attributes
      expect {
        delete tipo_contenido_url(tipo_contenido)
      }.to change(TipoContenido, :count).by(-1)
    end

    it "redirects to the tipo_contenidos list" do
      tipo_contenido = TipoContenido.create! valid_attributes
      delete tipo_contenido_url(tipo_contenido)
      expect(response).to redirect_to(tipo_contenidos_url)
    end
  end
end
