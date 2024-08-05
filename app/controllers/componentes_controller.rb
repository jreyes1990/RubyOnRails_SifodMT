class ComponentesController < ApplicationController
  before_action :set_componente, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /componentes or /componentes.json
  def index
    @componentes = Componente.where(:estado =>'A').order(:id)
  end

  # GET /componentes/1 or /componentes/1.json
  def show
  end

  # GET /componentes/new
  def new
    @componente = Componente.new
  end

  # GET /componentes/1/edit
  def edit
  end

  # POST /componentes or /componentes.json
  def create
    @componente = Componente.new(componente_params)
    @componente.estado = "A"
    @componente.user_created_id = current_user.id

    respond_to do |format|
      if @componente.save
        format.html { redirect_to componentes_path, notice: "Componente creado." }
        format.json { render :show, status: :created, location: @componente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @componente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /componentes/1 or /componentes/1.json
  def update
    @componente.user_updated_id = current_user.id
    respond_to do |format|
      if @componente.update(componente_params)
        format.html { redirect_to componentes_path, notice: "Componente Actualizado" }
        format.json { render :show, status: :ok, location: @componente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @componente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /componentes/1 or /componentes/1.json
  def destroy
    @componente.destroy
    respond_to do |format|
      format.html { redirect_to componentes_url, notice: "Componente was successfully destroyed." }
      format.json { head :no_content }
    end
  end

# Inactivar atributos
def inactivar_componente
  @componente = Componente.find(params[:id])
  @componente.user_updated_id = current_user.id
  @componente.estado = "I"
  respond_to do |format|
    if @componente.save
      format.html { redirect_to componentes_path, notice: "Componente Inctivado" }
      format.json { render :show, status: :created, location: @componente }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @componente.errors, status: :unprocessable_entity }
    end
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_componente
      @componente = Componente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def componente_params
      params.require(:componente).permit(:nombre, :descripcion, :estado, :user_created_id, :user_updated_id)
    end
end
