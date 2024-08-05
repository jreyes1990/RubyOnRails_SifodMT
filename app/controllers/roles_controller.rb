class RolesController < ApplicationController
  include ManageStatus
  before_action :set_rol, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /roles or /roles.json
  def index
    @roles = Rol.where(estado: ['A', 'I']).order(:id)
  end

  # GET /roles/1 or /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @rol = Rol.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles or /roles.json
  def create
    @rol = Rol.new(rol_params)
    @rol.estado = "A"
    @rol.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@rol, "No se pudo crear el rol", "Error de base de datos al crear el rol")

      respond_to do |format|
        format.html { redirect_to roles_url, notice: "El rol [ <strong>#{@rol.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: roles_url }
      end
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    @rol.user_updated_id = current_user.id

    ActiveRecord::Base.transaction do
      actualizar_con_manejo_de_excepciones(@rol, rol_params, "No se pudo actualizar el rol", "Error de base de datos al actualizar el rol")
      respond_to do |format|
        format.html { redirect_to roles_url, notice: "El rol [ <strong>#{@rol.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: roles_url }
      end
    end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    @rol.destroy
    respond_to do |format|
      format.html { redirect_to roles_path, notice: "Rol was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Inactivar rol
  def inactivar
    change_status_to('I', Rol, params[:id], roles_url)
  end

  def activar
    change_status_to('A', Rol, params[:id], roles_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rol
      @rol = Rol.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rol_params
      params.require(:rol).permit(Rol.attribute_names.map(&:to_sym))
    end
end
