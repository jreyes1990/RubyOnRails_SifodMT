class TipoSeleccionesController < ApplicationController
  include ManageStatus
  before_action :set_tipo_seleccion, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /tipo_selecciones or /tipo_selecciones.json
  def index
    @tipo_selecciones = TipoSeleccion.where(estado: ['A', 'I']).order(:id)
  end

  # GET /tipo_selecciones/1 or /tipo_selecciones/1.json
  def show
  end

  # GET /tipo_selecciones/new
  def new
    @tipo_seleccion = TipoSeleccion.new
  end

  # GET /tipo_selecciones/1/edit
  def edit
  end

  # POST /tipo_selecciones or /tipo_selecciones.json
  def create
    @tipo_seleccion = TipoSeleccion.new(tipo_seleccion_params)
    @tipo_seleccion.estado = "A"
    @tipo_seleccion.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@tipo_seleccion, "No se pudo crear el tipo de selección", "Error de base de datos al crear el tipo de selección")

      respond_to do |format|
        format.html { redirect_to tipo_selecciones_url, notice: "El tipo de selección [ <strong>#{@tipo_seleccion.id} | #{@tipo_seleccion.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: tipo_selecciones_url }
      end
    end
  end

  # PATCH/PUT /tipo_selecciones/1 or /tipo_selecciones/1.json
  def update
    @tipo_seleccion.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@tipo_seleccion, tipo_seleccion_params, "No se pudo actualizar el tipo de selección", "Error de base de datos al actualizar el tipo de selección")
      respond_to do |format|
        format.html { redirect_to tipo_selecciones_url, notice: "El tipo de selección [ <strong>#{@tipo_seleccion.id} | #{@tipo_seleccion.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: tipo_selecciones_url }
      end
    end
  end

  # DELETE /tipo_selecciones/1 or /tipo_selecciones/1.json
  def destroy
    @tipo_seleccion.destroy

    respond_to do |format|
      format.html { redirect_to tipo_selecciones_url, notice: "Tipo seleccion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def inactivar
    change_status_to('I', TipoSeleccion, params[:id], tipo_selecciones_url)
  end

  def activar
    change_status_to('A', TipoSeleccion, params[:id], tipo_selecciones_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_seleccion
      @tipo_seleccion = TipoSeleccion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tipo_seleccion_params
      params.require(:tipo_seleccion).permit(TipoSeleccion.attribute_names.map(&:to_sym))
    end
end
