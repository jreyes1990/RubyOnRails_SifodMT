class ConfigSubPreguntasController < ApplicationController
  include ManageStatus
  before_action :set_config_sub_pregunta, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /config_sub_preguntas or /config_sub_preguntas.json
  def index
    @config_sub_preguntas = ConfigSubPregunta.where(estado: ['A', 'I']).order(:id)
  end

  # GET /config_sub_preguntas/1 or /config_sub_preguntas/1.json
  def show
  end

  def search_empresa
    if params[:search_empresa_cfgSubPreg_params].present?
      @parametro = params[:search_empresa_cfgSubPreg_params].upcase

      @empresa = PgEmpresa.select(" id_empresa, (id_empresa||' - '||descripcion) codigo_empresa").where("id_empresa||upper(descripcion) like ?", "%#{@parametro}%").distinct

      respond_to do |format|
        format.json { render json: @empresa.map { |p| { valor_id: p.id_empresa, valor_text: p.codigo_empresa } } }
      end
    elsif params[:empresa_cfgSubPreg_params].present?
      @id_empresa = params[:empresa_cfgSubPreg_params]
      @areas_negocio = PgArea.where(id_empresa: @id_empresa).order(id_area: :asc)
      # @unidad_medidas = PgMedida.where.not("exists(select * from unidad_medidas um where um.medida_id=pg_medida.id_medida and um.empresa_id=?)", @id_empresa).order(id_medida: :asc)

      respond_to do |format|
        format.json {
          render json: {
            list_pg_area: @areas_negocio.map { |an| { valor_id: an.id_area, valor_text: "#{an.id_area} - #{an.descripcion.upcase}" } }
          }
        }
      end
    end
  end

  # GET /config_sub_preguntas/new
  def new
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_area = PgArea.where(id_empresa: @empresa_session_area)
    @config_sub_pregunta = ConfigSubPregunta.new
  end

  # GET /config_sub_preguntas/1/edit
  def edit
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @config_sub_pregunta.empresa_id)
    @listado_area = PgArea.where(id_empresa: @config_sub_pregunta.empresa_id)
  end

  # POST /config_sub_preguntas or /config_sub_preguntas.json
  def create
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_area = PgArea.where(id_empresa: @empresa_session_area)

    @config_sub_pregunta = ConfigSubPregunta.new(config_sub_pregunta_params)
    @config_sub_pregunta.estado = "A"
    @config_sub_pregunta.user_created_id = current_user.id
    @config_sub_pregunta.usr_grab = set_usr_grab(current_user)

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@config_sub_pregunta, "No se pudo crear la configuración de la sub-pregunta", "Error de base de datos al crear la configuración de la sub-pregunta")

      respond_to do |format|
        format.html { redirect_to config_sub_preguntas_url, notice: "La configuración de la sub-pregunta [ <strong>#{@config_sub_pregunta.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: config_sub_preguntas_url }
      end
    end
  end

  # PATCH/PUT /config_sub_preguntas/1 or /config_sub_preguntas/1.json
  def update
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_area = PgArea.where(id_empresa: @empresa_session_area)

    @config_sub_pregunta.user_updated_id = current_user.id
    @config_sub_pregunta.usr_modi = set_usr_modi(current_user)

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@config_sub_pregunta, config_sub_pregunta_params, "No se pudo actualizar la configuración de la sub-pregunta", "Error de base de datos al actualizar la configuración de la sub-pregunta")

      respond_to do |format|
        format.html { redirect_to config_sub_preguntas_url, notice: "La configuración de la sub-pregunta [ <strong>#{@config_sub_pregunta.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: config_sub_preguntas_url }
      end
    end
  end

  # DELETE /config_sub_preguntas/1 or /config_sub_preguntas/1.json
  def destroy
    @config_sub_pregunta.destroy

    respond_to do |format|
      format.html { redirect_to config_sub_preguntas_url, notice: "Config sub pregunta was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def inactivar
    change_status_to('I', ConfigSubPregunta, params[:id], config_sub_preguntas_url)
  end

  def activar
    change_status_to('A', ConfigSubPregunta, params[:id], config_sub_preguntas_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config_sub_pregunta
      @config_sub_pregunta = ConfigSubPregunta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def config_sub_pregunta_params
      params.require(:config_sub_pregunta).permit(ConfigSubPregunta.attribute_names.map(&:to_sym))
    end
end
