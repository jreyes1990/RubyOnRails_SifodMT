class ConfigFormulariosController < ApplicationController
  include ManageStatus
  before_action :set_config_formulario, only: %i[ show edit update destroy ]
  before_action :set_form_collections, only: [:edit, :update]
  before_action :comprobar_permiso

  # GET /config_formularios or /config_formularios.json
  def index
    # Eliminar el parámetro de la sesión
    session.delete(:params_session_empresa_cfgForm)
    session.delete(:params_session_area_cfgForm)

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
      session[:params_session_empresa_cfgForm] = params[:empresa_cfgForm_params]

      @areas_negocio = PgArea.where(id_empresa: @id_empresa).order(id_area: :asc)

      respond_to do |format|
        format.json {
          render json: {
            list_pg_area: @areas_negocio.present? ? @areas_negocio.map { |an| { valor_id: an.id_area, valor_text: "#{an.id_area} - #{an.descripcion.upcase}" } } : [],
            list_tipo_formulario: [],
            list_labor_oracle: [],
            list_documento_iso: [],
            list_config_pregunta: []
          }
        }
      end
    end
  end

  def search_area
    if params[:search_area_cfgForm_params].present? && (params[:empresa_cfgForm_params].present? || session[:params_session_empresa_cfgForm].present?)
      @id_empresa = params[:empresa_cfgForm_params].present? ? params[:empresa_cfgForm_params] : session[:params_session_empresa_cfgForm]
      @parametro = params[:search_area_cfgForm_params].upcase

      @area = PgArea.select(" id_area, (id_area||' - '||descripcion) codigo_area").where("id_empresa=#{@id_empresa} and id_area||upper(descripcion) like ?", "%#{@parametro}%").distinct

      respond_to do |format|
        format.json { render json: @area.map { |p| { valor_id: p.id_area, valor_text: p.codigo_area } } }
      end
    elsif params[:area_cfgForm_params].present? && params[:empresa_cfgForm_params].present?
      @id_empresa = params[:empresa_cfgForm_params]
      @id_area = params[:area_cfgForm_params]
      session[:params_session_empresa_cfgForm] = params[:empresa_cfgForm_params]
      session[:params_session_area_cfgForm] = params[:area_cfgForm_params]

      @tipo_formulario = TipoFormulario.where(empresa_id: @id_empresa, area_id: @id_area, estado: "A").order(id: :asc)
      
      respond_to do |format|
        format.json {
          render json: {
            list_tipo_formulario: @tipo_formulario.present? ? @tipo_formulario.map { |tf| { valor_id: tf.id, valor_text: "#{tf.id} - #{tf.nombre.upcase}" } } : [],
            list_pg_labor: [],
            list_documento_iso: [],
            list_config_pregunta: []
          }
        }
      end
    end
  end

  def search_tipo_form
    if params[:search_tipoForm_cfgForm_params].present?
      @id_empresa = params[:empresa_cfgForm_params].present? ? params[:empresa_cfgForm_params] : session[:params_session_empresa_cfgForm]
      @id_area = params[:area_cfgForm_params].present? ? params[:area_cfgForm_params] : session[:params_session_area_cfgForm]
      @parametro = params[:search_tipoForm_cfgForm_params].upcase

      @tipo_formulario = TipoFormulario.select(" id, (id||' - '||nombre) codigo_tipo_formulario")
                                       .where(empresa_id: @id_empresa, area_id: @id_area, estado: "A")
                                       .where("id||upper(nombre) like ?", "%#{@parametro}%")
                                       .distinct

      respond_to do |format|
        format.json { render json: @tipo_formulario.map { |p| { valor_id: p.id, valor_text: p.codigo_tipo_formulario } } }
      end
    elsif params[:tipoForm_cfgForm_params].present?
      @id_empresa = params[:empresa_cfgForm_params]
      @id_area = params[:area_cfgForm_params]
      @id_tipo_formulario = params[:tipoForm_cfgForm_params]

      @tipo_formulario = TipoFormulario.where(empresa_id: @id_empresa, area_id: @id_area, id: @id_tipo_formulario, estado: "A").first

      if @tipo_formulario.present?
        if @tipo_formulario.tipo_datascope == "DATASCOPE_CALIDAD"
          @labores_oracle = PgLabor.where(id_empresa: @id_empresa, id_area: @id_area)
                                  .where("datascope_calidad=?", "S")
                                  .order(id_labor: :asc)
        elsif @tipo_formulario.tipo_datascope == "DATASCOPE_CHECK_LIST"
          @labores_oracle = PgLabor.where(id_empresa: @id_empresa, id_area: @id_area)
                                  .where("datascope_check_list=?", "S")
                                  .order(id_labor: :asc)
        end
        @documentos_iso = SgiDocumento.joins("inner join sig.empresas on(sig.documentos.empresa_id=sig.empresas.id)").where("sig.empresas.codigo_empresa=?", @id_empresa).order(id: :asc)
        @config_preguntas = ConfigPregunta.where(empresa_id: @id_empresa, area_id: @id_area, estado: "A").order(id: :asc)
      end
      respond_to do |format|
        format.json {
          render json: {
            tiene_app_siga: @tipo_formulario.present? ? (@tipo_formulario.tipo_datascope.nil? ? false : true) : false,
            list_pg_labor: @tipo_formulario.present? ? (@labores_oracle.present? ? @labores_oracle.map { |lo| { valor_id: lo.id_labor, valor_text: "#{lo.id_labor} - #{lo.descripcion.upcase}" } } : []) : [],
            list_documento_iso: @tipo_formulario.present? ? (@documentos_iso.present? ? @documentos_iso.map { |di| { valor_id: di.id, valor_text: "#{di.codigo}#{format_digitos(di.correlativo, 3)} - #{di.nombre.upcase}" } } : []) : [],
            list_cfg_pregunta: @tipo_formulario.present? ? (@config_preguntas.present? ? @config_preguntas.map { |cp| { valor_id: cp.id, valor_text: "#{cp.id} - #{cp.nombre.upcase}" } } : []) : []
          }
        }
      end
    end
  end

  def search_pregunta
    puts("RECIBIENDO PARAMETROS DESDE PREGUNTA - CONFIG_FORMULARIOS:")
    puts("===================================================")
    puts("EMPRESA PARAMS: #{params[:empresa_cfgForm_params]}")
    puts("EMPRESA SESION: #{session[:params_session_empresa_cfgForm]}")
    puts("AREA PARAMS: #{params[:area_cfgForm_params]}")
    puts("AREA SESION: #{session[:params_session_area_cfgForm]}")

    if params[:search_pregunta_cfgForm_params].present?
      @id_empresa = params[:empresa_cfgForm_params].presence || session[:params_session_empresa_cfgForm]
      @id_area = params[:area_cfgForm_params].presence || session[:params_session_area_cfgForm]
      @parametro = params[:search_pregunta_cfgForm_params].upcase

      respond_to do |format|
        if @id_empresa && @id_area && @parametro.present?
          @pregunta = ConfigPregunta.select(" id, (id||' - '||nombre) instruccion_pregunta")
                                    .where(empresa_id: @id_empresa, area_id: @id_area, estado: "A")
                                    .where("id||upper(nombre) like ?", "%#{@parametro}%").distinct
          format.json { render json: @pregunta.map { |p| { valor_id: p.id, valor_text: p.instruccion_pregunta } } }
        else
          render json: { error: 'Parámetros insuficientes o incorrectos' }, status: :bad_request
        end
      end
    elsif params[:pregunta_cfgForm_params].present?
      puts("PREGUNTA: #{params[:pregunta_cfgForm_params]}")
      @id_empresa = params[:empresa_cfgForm_params].present? ? params[:empresa_cfgForm_params] : session[:params_session_empresa_cfgForm]
      @id_area = params[:area_cfgForm_params].present? ? params[:area_cfgForm_params] : session[:params_session_area_cfgForm]
      @id_pregunta = params[:pregunta_cfgForm_params]

      @config_pregunta = ConfigPregunta.where(empresa_id: @id_empresa, area_id: @id_area, id: @id_pregunta, estado: "A").first

      puts(" ENVIANDO BADERA: #{@config_pregunta.tiene_sub_pregunta}")

      if @config_pregunta.tiene_sub_pregunta
        @config_sub_preguntas = ConfigSubPregunta.where(empresa_id: @config_pregunta.empresa_id, area_id: @config_pregunta.area_id, estado: "A").order(id: :asc)
      else
        @config_sub_preguntas = ConfigSubPregunta.where(empresa_id: @config_pregunta.empresa_id, area_id: @config_pregunta.area_id, estado: "A").limit(0)
      end

      respond_to do |format|
        format.json {
          render json: {
            flag_tiene_sub_pregunta: @config_pregunta.tiene_sub_pregunta,
            list_cfg_sub_preguntas: @config_sub_preguntas.present? ? @config_sub_preguntas.map { |csp| { valor_id: csp.id, valor_text: "#{csp.id} - #{csp.nombre.upcase}" } } : []
          }
        }
      end
    end
    puts("===================================================")
  end

  # GET /config_formularios/new
  def new
    get_data_collections(@empresa_session_area)
    @config_formulario = ConfigFormulario.new
  end

  # GET /config_formularios/1/edit
  def edit
    
  end

  # POST /config_formularios or /config_formularios.json
  def create
    # Las consultas nos sirve para mantener los datos cuando ocurra un error
    get_data_collections(@empresa_session_area)

    @config_formulario = ConfigFormulario.new(config_formulario_params)
    @config_formulario.estado = "A"
    @config_formulario.user_created_id = current_user.id
    @config_formulario.usr_grab = set_usr_grab(current_user)

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@config_formulario, "No se pudo crear la configuración del formulario", "Error de base de datos al crear la configuración del formulario")
      # Eliminar el parámetro de la sesión
      # session.delete(:params_session_empresa_cfgForm)

      respond_to do |format|
        format.html { redirect_to config_formularios_url, notice: "La configuración del formulario [ <strong>#{@config_formulario.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: config_formularios_url }
      end
    end
  end

  # PATCH/PUT /config_formularios/1 or /config_formularios/1.json
  def update
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
    
    # Configuración de selecciones que se usaran en el formulario
    def set_form_collections
      session[:params_session_empresa_cfgForm] = @config_formulario.empresa_id
      session[:params_session_area_cfgForm] = @config_formulario.area_id
      @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @config_formulario.empresa_id)
      @listado_area = PgArea.where(id_empresa: @config_formulario.empresa_id, id_area: @config_formulario.area_id).order(id_area: :asc)
      @listado_tipo_formulario = TipoFormulario.where(empresa_id: @config_formulario.empresa_id, area_id: @config_formulario.area_id, estado: "A")
      @listado_labor = PgLabor.where(id_empresa: @config_formulario.empresa_id, id_area: @config_formulario.area_id).where("datascope_calidad=? or datascope_check_list=?", "S", "S")
      @listado_documento_iso = SgiDocumento.joins("inner join sig.empresas on(sig.documentos.empresa_id=sig.empresas.id)").where("sig.empresas.codigo_empresa=?", @config_formulario.empresa_id)
      @listado_preguntas = ConfigPregunta.where(empresa_id: @config_formulario.empresa_id, area_id: @config_formulario.area_id, estado: "A")
      @listado_sub_preguntas = ConfigSubPregunta.where(empresa_id: @config_formulario.empresa_id, area_id: @config_formulario.area_id, estado: "A")
    end

    def get_data_collections(empresa_id)
      @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: empresa_id)
      @listado_area = PgArea.where(id_empresa: empresa_id)
      @listado_tipo_formulario = TipoFormulario.where(empresa_id: empresa_id, estado: "A")
      @listado_labor = PgLabor.where(id_empresa: empresa_id)
      @listado_documento_iso = SgiDocumento.joins("inner join sig.empresas on(sig.documentos.empresa_id=sig.empresas.id)").where("sig.empresas.codigo_empresa=?", empresa_id)
      @listado_preguntas = ConfigPregunta.where(empresa_id: empresa_id, estado: "A")
      @listado_sub_preguntas = ConfigSubPregunta.where(empresa_id: empresa_id, estado: "A").limit(0)
    end

    # Only allow a list of trusted parameters through.
    def config_formulario_params
      params.require(:config_formulario).permit(ConfigFormulario.attribute_names.map(&:to_sym).push(:_destroy), config_formulario_preguntas_attributes: ConfigFormularioPregunta.attribute_names.map(&:to_sym).push(:_destroy))
    end
end
