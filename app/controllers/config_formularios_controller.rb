class ConfigFormulariosController < ApplicationController
  include ManageStatus
  before_action :set_config_formulario, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /config_formularios or /config_formularios.json
  def index
    @config_formularios = ConfigFormulario.where(estado: ['A', 'I']).order(:id)
  end

  # GET /config_formularios/1 or /config_formularios/1.json
  def show
  end

  def search_empresa
    if params[:search_empresa_cfgForm_params].present?
      @parametro = params[:search_empresa_cfgForm_params].upcase

      @empresa = PgEmpresa.select(" id_empresa, (id_empresa||' - '||descripcion) codigo_empresa").where("id_empresa||upper(descripcion) like ?", "%#{@parametro}%").distinct

      respond_to do |format|
        format.json { render json: @empresa.map { |p| { valor_id: p.id_empresa, valor_text: p.codigo_empresa } } }
      end
    elsif params[:empresa_cfgForm_params].present?
      @id_empresa = params[:empresa_cfgForm_params]
      @areas_negocio = PgArea.where(id_empresa: @id_empresa).order(id_area: :asc)
      @tipo_formulario = TipoFormulario.where(empresa_id: @id_empresa).order(id: :asc)

      respond_to do |format|
        format.json {
          render json: {
            list_pg_area: @areas_negocio.map { |an| { valor_id: an.id_area, valor_text: "#{an.id_area} - #{an.descripcion.upcase}" } }
          }
        }
      end
    end
  end

  # GET /config_formularios/new
  def new
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_area = PgArea.where(id_empresa: @empresa_session_area).order(id_area: :asc)
    @listado_tipo_formulario = TipoFormulario.where(empresa_id: @empresa_session_area).limit(0)
    @config_formulario = ConfigFormulario.new
  end

  # GET /config_formularios/1/edit
  def edit
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @config_formulario.empresa_id)
    @listado_area = PgArea.where(id_empresa: @config_formulario.empresa_id).order(id_area: :asc)
    @listado_tipo_formulario = TipoFormulario.where(empresa_id: @config_formulario.empresa_id, area_id: @config_formulario.area_id)
  end

  # POST /config_formularios or /config_formularios.json
  def create
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_area = PgArea.where(id_empresa: @empresa_session_area)

    @config_formulario = ConfigFormulario.new(config_formulario_params)
    @config_formulario.estado = "A"
    @config_formulario.user_created_id = current_user.id
    @config_formulario.usr_grab = set_usr_grab(current_user)

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@config_formulario, "No se pudo crear la configuración del formulario", "Error de base de datos al crear la configuración del formulario")

      respond_to do |format|
        format.html { redirect_to config_formularios_url, notice: "La configuración del formulario [ <strong>#{@config_formulario.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: config_formularios_url }
      end
    end
  end

  # PATCH/PUT /config_formularios/1 or /config_formularios/1.json
  def update
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @config_formulario.empresa_id)
    @listado_area = PgArea.where(id_empresa: @config_formulario.empresa_id)

    @config_formulario.user_updated_id = current_user.id
    @config_formulario.usr_modi = set_usr_modi(current_user)

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@config_formulario, config_formulario_params, "No se pudo actualizar la configuración del formulario", "Error de base de datos al actualizar la configuración del formulario")

      respond_to do |format|
        format.html { redirect_to config_formularios_url, notice: "La configuración del formulario [ <strong>#{@config_formulario.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: config_formularios_url }
      end
    end
  end

  # DELETE /config_formularios/1 or /config_formularios/1.json
  def destroy
    @config_formulario.destroy

    respond_to do |format|
      format.html { redirect_to config_formularios_url, notice: "Config formulario was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def inactivar
    change_status_to('I', ConfigFormulario, params[:id], config_formularios_url)
  end

  def activar
    change_status_to('A', ConfigFormulario, params[:id], config_formularios_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config_formulario
      @config_formulario = ConfigFormulario.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def config_formulario_params
      params.require(:config_formulario).permit(ConfigFormulario.attribute_names.map(&:to_sym))
    end
end
