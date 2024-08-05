class AreasController < ApplicationController
  include ManageStatus
  before_action :set_area, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /areas or /areas.json
  def index
    #@areas = Area.all
    @areas = Area.where(estado: ['A', 'I']).order(:id)
  end

  # GET /areas/1 or /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas or /areas.json
  def create
    @area = Area.new(area_params)
    @area.estado = "A"
    @area.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@area, "No se pudo crear el área", "Error de base de datos al crear el área")

      respond_to do |format|
        format.html { redirect_to areas_url, notice: "El área [ <strong>#{@area.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: areas_url }
      end
    end

    # respond_to do |format|
    #   begin
    #     ActiveRecord::Base.transaction do
    #       guardar_con_manejo_de_excepciones(@area, "No se pudo crear el área", "Error de base de datos al crear el área")
    #       format.html { redirect_to areas_url, notice: "El área <strong>#{@area.nombre}</strong> se ha creado correctamente.".html_safe }
    #       format.json { render :show, status: :created, location: areas_url }
    #     end
    #   rescue StandardError => e
    #     Rails.logger.error("ERROR EN CONSOLA: #{e.message}")
    #     flash[:error] = e.message
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: { error: e.message }, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /areas/1 or /areas/1.json
  def update
    @area.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@area, area_params, "No se pudo actualizar el área", "Error de base de datos al actualizar el área")
      respond_to do |format|
        format.html { redirect_to areas_url, notice: "El área [ <strong>#{@area.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: areas_url }
      end
    end

    # respond_to do |format|
    #   begin
    #     ActiveRecord::Base.transaction do
    #       actualizar_con_manejo_de_excepciones(@area, area_params, "No se pudo actualizar el área", "Error de base de datos al actualizar el área")
    #       format.html { redirect_to areas_url, notice: "El área <strong>#{@area.nombre}</strong> se ha actualizado correctamente.".html_safe }
    #       format.json { render :show, status: :ok, location: areas_url }
    #     end
    #   rescue StandardError => e
    #     Rails.logger.error("ERROR EN CONSOLA: #{e.message}")
    #     flash[:error] = e.message
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: { error: e.message }, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /areas/1 or /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_url, notice: "El área <strong>#{@area.nombre}</strong> se ha eliminado correctamente.".html_safe }
      format.json { head :no_content }
    end
  end

  # Inactivar area
  def inactivar
    change_status_to('I', Area, params[:id], areas_url)
  end

  def activar
    change_status_to('A', Area, params[:id], areas_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def area_params
      params.require(:area).permit(Area.attribute_names.map(&:to_sym))
    end
end
