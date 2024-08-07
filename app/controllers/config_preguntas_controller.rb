class ConfigPreguntasController < ApplicationController
  include ManageStatus
  before_action :set_config_pregunta, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /config_preguntas or /config_preguntas.json
  def index
    @config_preguntas = ConfigPregunta.where(estado: ['A', 'I']).order(:id)
  end

  # GET /config_preguntas/1 or /config_preguntas/1.json
  def show
  end

  def search_empresa
    if params[:search_empresa_cfgPreg_params].present?
      @parametro = params[:search_empresa_cfgPreg_params].upcase

      @empresa = PgEmpresa.select(" id_empresa, (id_empresa||' - '||descripcion) codigo_empresa").where("id_empresa||upper(descripcion) like ?", "%#{@parametro}%").distinct

      respond_to do |format|
        format.json { render json: @empresa.map { |p| { valor_id: p.id_empresa, valor_text: p.codigo_empresa } } }
      end
    elsif params[:empresa_cfgPreg_params].present?
      @id_empresa = params[:empresa_cfgPreg_params]
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

  # GET /config_preguntas/new
  def new
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_area = PgArea.where(id_empresa: @empresa_session_area)
    @config_pregunta = ConfigPregunta.new
  end

  # GET /config_preguntas/1/edit
  def edit
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @config_pregunta.empresa_id)
    @listado_area = PgArea.where(id_empresa: @config_pregunta.empresa_id)
  end

  # POST /config_preguntas or /config_preguntas.json
  def create
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_area = PgArea.where(id_empresa: @empresa_session_area)

    @config_pregunta = ConfigPregunta.new(config_pregunta_params)
    @config_pregunta.estado = "A"
    @config_pregunta.user_created_id = current_user.id
    @config_pregunta.usr_grab = set_usr_grab(current_user)

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@config_pregunta, "No se pudo crear la configuración de la pregunta", "Error de base de datos al crear la configuración de la pregunta")

      respond_to do |format|
        format.html { redirect_to config_preguntas_url, notice: "La configuración de la pregunta [ <strong>#{@config_pregunta.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: config_preguntas_url }
      end
    end
  end

  # PATCH/PUT /config_preguntas/1 or /config_preguntas/1.json
  def update
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @config_pregunta.empresa_id)
    @listado_area = PgArea.where(id_empresa: @config_pregunta.empresa_id)

    @config_pregunta.user_updated_id = current_user.id
    @config_pregunta.usr_modi = set_usr_modi(current_user)

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@config_pregunta, config_pregunta_params, "No se pudo actualizar la configuración de la pregunta", "Error de base de datos al actualizar la configuración de la pregunta")

      respond_to do |format|
        format.html { redirect_to config_preguntas_url, notice: "La configuración de la pregunta [ <strong>#{@config_pregunta.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: config_preguntas_url }
      end
    end
  end

  # DELETE /config_preguntas/1 or /config_preguntas/1.json
  def destroy
    @config_pregunta.destroy

    respond_to do |format|
      format.html { redirect_to config_preguntas_url, notice: "Config pregunta was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def inactivar
    change_status_to('I', ConfigPregunta, params[:id], config_preguntas_url)
  end

  def activar
    change_status_to('A', ConfigPregunta, params[:id], config_preguntas_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config_pregunta
      @config_pregunta = ConfigPregunta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def config_pregunta_params
      params.require(:config_pregunta).permit(ConfigPregunta.attribute_names.map(&:to_sym))
    end
end
