class UnidadMedidasController < ApplicationController
  include ManageStatus
  before_action :set_unidad_medida, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /unidad_medidas or /unidad_medidas.json
  def index
    @unidad_medidas = UnidadMedida.where(estado: ['A', 'I'], empresa_id: @empresa_session_area).order(:id)
  end

  # GET /unidad_medidas/1 or /unidad_medidas/1.json
  def show
  end

  def search_empresa
    if params[:search_empresa_unidad_medida_params].present?
      @parametro = params[:search_empresa_unidad_medida_params].upcase

      @empresa = PgEmpresa.select(" id_empresa, (id_empresa||' - '||descripcion) codigo_empresa").where("id_empresa||upper(descripcion) like ?", "%#{@parametro}%").distinct
    
      respond_to do |format|
        format.json { render json: @empresa.map { |p| { valor_id: p.id_empresa, valor_text: p.codigo_empresa } } }
      end 
    elsif params[:empresa_unidad_medida_params].present?
      @id_empresa = params[:empresa_unidad_medida_params]
      @unidad_medidas = PgMedida.all.order(id_medida: :asc)
      # @unidad_medidas = PgMedida.where.not("exists(select * from unidad_medidas um where um.medida_id=pg_medida.id_medida and um.empresa_id=?)", @id_empresa).order(id_medida: :asc)

      respond_to do |format|
        format.json {
          render json: {
            list_pg_medida: @unidad_medidas.map { |um| { valor_id: um.id_medida, valor_text: "#{um.id_medida} - #{um.descripcion.upcase}" } }
          }
        }
      end
    end 
  end

  def search_datos
    if params[:search_datos_unidad_medida_params].present?
      @parametro = params[:search_datos_unidad_medida_params].upcase

      @medidas = PgMedida.select("id_medida, (id_medida || ' - ' || descripcion) AS codigo_medida")
                        .where("id_medida || upper(descripcion) LIKE ?", "%#{@parametro}%")
                        .distinct

      respond_to do |format|
        format.json { render json: @medidas.map { |m| { valor_id: m.id_medida, valor_text: m.codigo_medida } } }
      end
    elsif params[:datos_unidad_medida_params].present?
      @id_medida = params[:datos_unidad_medida_params]
      @datos_validos = PgMedida.where(id_medida: @id_medida).first # Ajustar según la lógica de tu aplicación

      respond_to do |format|
        format.json {
          render json: {
            nombre_pg_medida: @datos_validos.descripcion.present? ? @datos_validos.descripcion : [],
            abr_pg_medida: @datos_validos.abreviatura.present? ? @datos_validos.abreviatura : []
          }
        }
      end
    end
  end

  # GET /unidad_medidas/new
  def new
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_unidad_medida = PgMedida.all
    @unidad_medida = UnidadMedida.new
  end

  # GET /unidad_medidas/1/edit
  def edit
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_unidad_medida = PgMedida.all
  end

  # POST /unidad_medidas or /unidad_medidas.json
  def create
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_unidad_medida = PgMedida.all

    @unidad_medida = UnidadMedida.new(unidad_medida_params)
    @unidad_medida.estado = "A"
    @unidad_medida.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@unidad_medida, "No se pudo crear la unidad de medida", "Error de base de datos al crear la unidad de medida")

      respond_to do |format|
        format.html { redirect_to unidad_medidas_url, notice: "La unidad de medida [ <strong>#{@unidad_medida.medida_id} | #{@unidad_medida.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: unidad_medidas_url }
      end
    end
  end

  # PATCH/PUT /unidad_medidas/1 or /unidad_medidas/1.json
  def update
    @listado_empresa = PgEmpresa.where(STATUS: 'A', id_empresa: @empresa_session_area)
    @listado_unidad_medida = PgMedida.all
    @unidad_medida.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@unidad_medida, unidad_medida_params, "No se pudo actualizar la unidad de medida", "Error de base de datos al actualizar la unidad de medida")
      respond_to do |format|
        format.html { redirect_to unidad_medidas_url, notice: "La unidad de medida [ <strong>#{@unidad_medida.medida_id} | #{@unidad_medida.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: unidad_medidas_url }
      end
    end
  end

  # DELETE /unidad_medidas/1 or /unidad_medidas/1.json
  def destroy
    @unidad_medida.destroy

    respond_to do |format|
      format.html { redirect_to unidad_medidas_url, notice: "Unidad medida was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def inactivar
    change_status_to('I', UnidadMedida, params[:id], unidad_medidas_url)
  end

  def activar
    change_status_to('A', UnidadMedida, params[:id], unidad_medidas_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unidad_medida
      @unidad_medida = UnidadMedida.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def unidad_medida_params
      params.require(:unidad_medida).permit(UnidadMedida.attribute_names.map(&:to_sym))
    end
end
