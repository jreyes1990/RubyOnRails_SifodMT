class TipoFrecuenciasController < ApplicationController
  include ManageStatus
  before_action :set_tipo_frecuencia, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /tipo_frecuencias or /tipo_frecuencias.json
  def index
    @tipo_frecuencias = TipoFrecuencia.where(estado: ['A', 'I']).order(:id)
  end

  # GET /tipo_frecuencias/1 or /tipo_frecuencias/1.json
  def show
  end

  def search_empresa
    if params[:search_empresa_tipo_frecuencia_params].present?
      @parametro = params[:search_empresa_tipo_frecuencia_params].upcase

      @empresa = PgEmpresa.select(" id_empresa, (id_empresa||' - '||descripcion) codigo_empresa").where("id_empresa||upper(descripcion) like ?", "%#{@parametro}%").distinct
    
      respond_to do |format|
        format.json { render json: @empresa.map { |p| { valor_id: p.id_empresa, valor_text: p.codigo_empresa } } }
      end 
    elsif params[:empresa_tipo_frecuencia_params].present?
      @id_empresa = params[:empresa_tipo_frecuencia_params]
    end 
  end

  # GET /tipo_frecuencias/new
  def new
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @tipo_frecuencia = TipoFrecuencia.new
  end

  # GET /tipo_frecuencias/1/edit
  def edit
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
  end

  # POST /tipo_frecuencias or /tipo_frecuencias.json
  def create
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)

    @tipo_frecuencia = TipoFrecuencia.new(tipo_frecuencia_params)
    @tipo_frecuencia.estado = "A"
    @tipo_frecuencia.user_created_id = current_user.id
    @tipo_frecuencia.usr_grab = set_usr_grab(current_user)

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@tipo_frecuencia, "No se pudo crear el tipo de frecuencia", "Error de base de datos al crear el tipo de frecuencia")

      respond_to do |format|
        format.html { redirect_to tipo_frecuencias_url, notice: "El tipo de frecuencia [ <strong>#{@tipo_frecuencia.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: tipo_frecuencias_url }
      end
    end
  end

  # PATCH/PUT /tipo_frecuencias/1 or /tipo_frecuencias/1.json
  def update
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    
    @tipo_frecuencia.user_updated_id = current_user.id
    @tipo_frecuencia.usr_modi = set_usr_modi(current_user)

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@tipo_frecuencia, tipo_frecuencia_params, "No se pudo actualizar el tipo de frecuencia", "Error de base de datos al actualizar el tipo de frecuencia")

      respond_to do |format|
        format.html { redirect_to tipo_frecuencias_url, notice: "El tipo de frecuencia [ <strong>#{@tipo_frecuencia.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: tipo_frecuencias_url }
      end
    end
  end

  # DELETE /tipo_frecuencias/1 or /tipo_frecuencias/1.json
  def destroy
    @tipo_frecuencia.destroy

    respond_to do |format|
      format.html { redirect_to tipo_frecuencias_url, notice: "Tipo frecuencia was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def inactivar
    change_status_to('I', TipoFrecuencia, params[:id], tipo_frecuencias_url)
  end

  def activar
    change_status_to('A', TipoFrecuencia, params[:id], tipo_frecuencias_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_frecuencia
      @tipo_frecuencia = TipoFrecuencia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tipo_frecuencia_params
      params.require(:tipo_frecuencia).permit(TipoFrecuencia.attribute_names.map(&:to_sym))
    end
end
