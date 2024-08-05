class SubOpcionesController < ApplicationController
  include ManageStatus
  before_action :set_sub_opcion, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /sub_opciones or /sub_opciones.json
  def index
    @sub_opciones = SubOpcion.where(estado: ['A', 'I'])
  end

  # GET /sub_opciones/1 or /sub_opciones/1.json
  def show
  end

  # GET /sub_opciones/new
  def new
    @sub_opcion = SubOpcion.new
  end

  # GET /sub_opciones/1/edit
  def edit
  end

  # POST /sub_opciones or /sub_opciones.json
  def create
    @sub_opcion = SubOpcion.new(sub_opcion_params)
    @sub_opcion.estado = "A"
    @sub_opcion.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@sub_opcion, "No se pudo crear la sub-opción", "Error de base de datos al crear la sub-opción")

      respond_to do |format|
        format.html { redirect_to sub_opciones_url, notice: "La sub-opción [ <strong>#{@sub_opcion.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: sub_opciones_url }
      end
    end
  end

  # PATCH/PUT /sub_opciones/1 or /sub_opciones/1.json
  def update
    @sub_opcion.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@sub_opcion, sub_opcion_params, "No se pudo actualizar la sub-opción", "Error de base de datos al actualizar la sub-opción")

      respond_to do |format|
        format.html { redirect_to sub_opciones_url, notice: "La sub-opción [ <strong>#{@sub_opcion.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: sub_opciones_url }
      end
    end
  end

  # DELETE /sub_opciones/1 or /sub_opciones/1.json
  def destroy
    @sub_opcion.destroy

    respond_to do |format|
      format.html { redirect_to sub_opciones_url, notice: "Sub opcion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def inactivar
    change_status_to('I', SubOpcion, params[:id], sub_opciones_url)
  end

  def activar
    change_status_to('A', SubOpcion, params[:id], sub_opciones_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_opcion
      @sub_opcion = SubOpcion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sub_opcion_params
      params.require(:sub_opcion).permit(SubOpcion.attribute_names.map(&:to_sym))
    end
end
