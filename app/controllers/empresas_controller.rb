class EmpresasController < ApplicationController
  include ManageStatus
  before_action :set_empresa, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /empresas or /empresas.json
  def index
    @empresas = Empresa.where(estado: ['A', 'I']).order(:id)
  end

  # GET /empresas/1 or /empresas/1.json
  def show
  end

  # GET /empresas/new
  def new
    @empresa = Empresa.new
  end

  # GET /empresas/1/edit
  def edit
  end

  # POST /empresas or /empresas.json
  def create
    @empresa = Empresa.new(empresa_params)
    @empresa.estado = "A"
    @empresa.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@empresa, "No se pudo crear la empresa", "Error de base de datos al crear la empresa")

      respond_to do |format|
        format.html { redirect_to empresas_path, notice: "La empresa [ <strong>#{@empresa.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: empresas_path }
      end
    end
  end

  # PATCH/PUT /empresas/1 or /empresas/1.json
  def update
    @empresa.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@empresa, empresa_params, "No se pudo actualizar el área", "Error de base de datos al actualizar el área")
      respond_to do |format|
        format.html { redirect_to empresas_url, notice: "La empresa [ <strong>#{@empresa.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: empresas_url }
      end
    end
  end

  # DELETE /empresas/1 or /empresas/1.json
  def destroy
    @empresa.destroy
    respond_to do |format|
      format.html { redirect_to empresas_url, notice: "La empresa se ha eliminado correctamente." }
      format.json { head :no_content }
    end
  end

  def inactivar
    change_status_to('I', Empresa, params[:id], empresas_url)
  end

  def activar
    change_status_to('A', Empresa, params[:id], empresas_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empresa
      @empresa = Empresa.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def empresa_params
      params.require(:empresa).permit(Empresa.attribute_names.map(&:to_sym))
    end
end
