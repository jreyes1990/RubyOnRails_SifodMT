class MenuRolesController < ApplicationController
  include ManageStatus
  before_action :set_menu_rol, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /menu_roles or /menu_roles.json
  def index
    @menu_roles = MenuRol.where(estado: ['A', 'I']).order(:id)
  end

  # GET /menu_roles/1 or /menu_roles/1.json
  def show
  end

  # GET /menu_roles/new
  def new
    @menu_rol = MenuRol.new
  end

  # GET /menu_roles/1/edit
  def edit
  end

  # POST /menu_roles or /menu_roles.json
  def create
    @menu_rol = MenuRol.new(menu_rol_params)
    @menu_rol.estado = "A"
    @menu_rol.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@menu_rol, "No se pudo crear el menú por rol", "Error de base de datos al crear el menú por rol")

      respond_to do |format|
        format.html { redirect_to menu_roles_url, notice: "El Menú - Rol [ <strong>#{@menu_rol.menu.nombre.upcase} - #{@menu_rol.opcion.nombre.upcase} - #{@menu_rol.rol.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: menu_roles_url }
      end
    end
  end

  # PATCH/PUT /menu_roles/1 or /menu_roles/1.json
  def update
    @menu_rol.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@menu_rol, menu_rol_params, "No se pudo actualizar el área", "Error de base de datos al actualizar el área")
      respond_to do |format|
        format.html { redirect_to menu_roles_url, notice: "El Menú - Rol [ <strong>#{@menu_rol.menu.nombre.upcase} - #{@menu_rol.opcion.nombre.upcase} - #{@menu_rol.rol.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: menu_roles_url }
      end
    end
  end

  # DELETE /menu_roles/1 or /menu_roles/1.json
  def destroy
    @menu_rol.destroy
    respond_to do |format|
      format.html { redirect_to menu_roles_url, notice: "Menu rol was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Inactivar area
  def inactivar
    change_status_to('I', MenuRol, params[:id], menu_roles_url)
  end

  def inactivar
    change_status_to('A', MenuRol, params[:id], menu_roles_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_rol
      @menu_rol = MenuRol.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_rol_params
      params.require(:menu_rol).permit(MenuRol.attribute_names.map(&:to_sym))
    end
end
