class TipoCamposController < ApplicationController
  include ManageStatus
  before_action :set_tipo_campo, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /tipo_campos or /tipo_campos.json
  def index
    @tipo_campos = TipoCampo.where(estado: ['A', 'I']).order(:id)
  end

  # GET /tipo_campos/1 or /tipo_campos/1.json
  def show
  end

  # GET /tipo_campos/new
  def new
    @tipo_campo = TipoCampo.new
  end

  # GET /tipo_campos/1/edit
  def edit
  end

  # POST /tipo_campos or /tipo_campos.json
  def create
    @tipo_campo = TipoCampo.new(tipo_campo_params)
    @tipo_campo.estado = "A"
    @tipo_campo.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@tipo_campo, "No se pudo crear el tipo de campo", "Error de base de datos al crear el tipo de campo")

      respond_to do |format|
        format.html { redirect_to tipo_campos_url, notice: "El tipo de campo [ <strong>#{@tipo_campo.nombre.upcase} (#{@tipo_campo.tipo_dato})</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: tipo_campos_url }
      end
    end
  end

  # PATCH/PUT /tipo_campos/1 or /tipo_campos/1.json
  def update
    @tipo_campo.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@tipo_campo, tipo_campo_params, "No se pudo actualizar el tipo de campo", "Error de base de datos al actualizar el tipo de campo")
      respond_to do |format|
        format.html { redirect_to tipo_campos_url, notice: "El tipo de campo [ <strong>#{@tipo_campo.nombre.upcase} (#{@tipo_campo.tipo_dato})</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: tipo_campos_url }
      end
    end
  end

  # DELETE /tipo_campos/1 or /tipo_campos/1.json
  def destroy
    @tipo_campo.destroy

    respond_to do |format|
      format.html { redirect_to tipo_campos_url, notice: "Tipo campo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def inactivar
    change_status_to('I', TipoCampo, params[:id], tipo_campos_url)
  end

  def activar
    change_status_to('A', TipoCampo, params[:id], tipo_campos_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_campo
      @tipo_campo = TipoCampo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tipo_campo_params
      params.require(:tipo_campo).permit(TipoCampo.attribute_names.map(&:to_sym))
    end
end
