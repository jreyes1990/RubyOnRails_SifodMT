class MenusController < ApplicationController
  include ManageStatus
  before_action :set_menu, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /menus or /menus.json
  def index
    @menus = Menu.where(estado: ['A', 'I']).order(:id)
  end

  # GET /menus/1 or /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus or /menus.json
  def create
    @menu = Menu.new(menu_params)
    @menu.estado = "A"
    @menu.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@menu, "No se pudo crear el menú", "Error de base de datos al crear el menú")

      respond_to do |format|
        format.html { redirect_to menus_url, notice: "El menú [ <strong>#{@menu.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: menus_url }
      end
    end
  end

  # PATCH/PUT /menus/1 or /menus/1.json
  def update
    @menu.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@menu, menu_params, "No se pudo actualizar el menú", "Error de base de datos al actualizar el menú")
      respond_to do |format|
        format.html { redirect_to menus_url, notice: "El menú [ <strong>#{@menu.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: menus_url }
      end
    end
  end

  # DELETE /menus/1 or /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url, notice: "Menu was successfully destroyed." }
      format.json { head :no_content }
    end
  end

 # Inactivar menu
  def inactivar
    change_status_to('I', Menu, params[:id], menus_url)
  end

  def activar
    change_status_to('A', Menu, params[:id], menus_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_params
      params.require(:menu).permit(Menu.attribute_names.map(&:to_sym))
    end
end
