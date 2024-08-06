class TipoContenidosController < ApplicationController
  include ManageStatus
  before_action :set_tipo_contenido, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /tipo_contenidos or /tipo_contenidos.json
  def index
    @tipo_contenidos = TipoContenido.where(estado: ['A', 'I']).order(:id)
  end

  # GET /tipo_contenidos/1 or /tipo_contenidos/1.json
  def show
  end

  # GET /tipo_contenidos/new
  def new
    @tipo_contenido = TipoContenido.new
  end

  # GET /tipo_contenidos/1/edit
  def edit
  end

  # POST /tipo_contenidos or /tipo_contenidos.json
  def create
    @tipo_contenido = TipoContenido.new(tipo_contenido_params)
    @tipo_contenido.estado = "A"
    @tipo_contenido.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@tipo_contenido, "No se pudo crear el tipo de contenido", "Error de base de datos al crear el tipo de contenido")

      respond_to do |format|
        format.html { redirect_to tipo_contenidos_url, notice: "El tipo de contenido [ <strong>#{@tipo_contenido.nombre.upcase} (#{@tipo_contenido.content_type})</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: tipo_contenidos_url }
      end
    end
  end

  # PATCH/PUT /tipo_contenidos/1 or /tipo_contenidos/1.json
  def update
    @tipo_contenido.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@tipo_contenido, tipo_contenido_params, "No se pudo actualizar el tipo de contenido", "Error de base de datos al actualizar el tipo de contenido")
      respond_to do |format|
        format.html { redirect_to tipo_contenidos_url, notice: "El tipo de contenido [ <strong>#{@tipo_contenido.nombre.upcase} (#{@tipo_contenido.content_type})</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: tipo_contenidos_url }
      end
    end
  end

  # DELETE /tipo_contenidos/1 or /tipo_contenidos/1.json
  def destroy
    @tipo_contenido.destroy

    respond_to do |format|
      format.html { redirect_to tipo_contenidos_url, notice: "Tipo contenido was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def inactivar
    change_status_to('I', TipoContenido, params[:id], tipo_contenidos_url)
  end

  def activar
    change_status_to('A', TipoContenido, params[:id], tipo_contenidos_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_contenido
      @tipo_contenido = TipoContenido.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tipo_contenido_params
      params.require(:tipo_contenido).permit(TipoContenido.attribute_names.map(&:to_sym))
    end
end
