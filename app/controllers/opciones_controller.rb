class OpcionesController < ApplicationController
  include ManageStatus
  before_action :set_opcion, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /opciones or /opciones.json
  def index
    @opciones = Opcion.where(estado: ['A', 'I'])
  end

  # GET /opciones/1 or /opciones/1.json
  def show
  end

  # GET /opciones/new
  def new
    @opcion = Opcion.new
  end

  # GET /opciones/1/edit
  def edit
  end

  # POST /opciones or /opciones.json
  def create
    @opcion = Opcion.new(opcion_params)
    @opcion.estado = "A"
    @opcion.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@opcion, "No se pudo crear la opción", "Error de base de datos al crear la opción")

      respond_to do |format|
        format.html { redirect_to opciones_url, notice: "La opción [ <strong>#{@opcion.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: opciones_url }
      end
    end
  end

  # PATCH/PUT /opciones/1 or /opciones/1.json
  def update
    @opcion.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@opcion, opcion_params, "No se pudo actualizar la opción", "Error de base de datos al actualizar la opción")
      
      respond_to do |format|
        format.html { redirect_to opciones_url, notice: "La opción [ <strong>#{@opcion.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: opciones_url }
      end
    end
  end

  # DELETE /opciones/1 or /opciones/1.json
  def destroy
    @opcion.destroy
    respond_to do |format|
      format.html { redirect_to opciones_url, notice: "Opcion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

   # Inactivar opciones
  def inactivar
    change_status_to('I', Opcion, params[:id], opciones_url)
  end

  def activar
    change_status_to('A', Opcion, params[:id], opciones_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opcion
      @opcion = Opcion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def opcion_params
      params.require(:opcion).permit(Opcion.attribute_names.map(&:to_sym))
    end
end
